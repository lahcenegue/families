import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../Apis/search_api.dart';
import '../Models/search_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/api_methods.dart';
import '../Utils/Constants/app_strings.dart';
import '../View_models/search_view_model.dart';

class SearchProvider extends ChangeNotifier {
  SharedPreferences? _prefs;

  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  bool isLoading = false;
  SearchViewModel? searchViewModel;
  List<String> _searchHistory = [];
  String filterOption = 'family';
  Timer? debounce;

  SearchProvider() {
    initial();
  }

  List<String> get searchHistory => _searchHistory;

  Future<void> initial() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSearchHistory();
  }

  void onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      search(query: query);
    });
  }

  Future<void> search({required String query}) async {
    if (query.isEmpty) {
      searchViewModel = null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
      return;
    }

    isSearching = true;
    addSearchWord(query);

    RequestModel requestModel = RequestModel(
      method: ApiMethods.searchMethode,
      query: query,
    );

    try {
      SearchModel searchModel = await searchApi(searchRequest: requestModel);

      if (searchModel.status == 'success') {
        searchViewModel = SearchViewModel(searchModel: searchModel);
      } else {
        searchViewModel = null;
        debugPrint('Failed to fetch search results');
      }
    } catch (e) {
      searchViewModel = null;
      debugPrint('Error fetching search results: $e');
    } finally {
      isSearching = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void addSearchWord(String word) {
    if (!_searchHistory.contains(word)) {
      _searchHistory.add(word);
      _saveSearchHistory();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void deleteSearchWord(String word) {
    _searchHistory.remove(word);
    _saveSearchHistory();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void clearSearchHistory() {
    _searchHistory.clear();
    _prefs?.remove(PrefKeys.searchHistory);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setIsSearching(bool value) {
    isSearching = value;
    notifyListeners();
  }

  void setFilterOption(String value) {
    filterOption = value;
    notifyListeners();
  }

  void _loadSearchHistory() {
    _searchHistory = _prefs?.getStringList(PrefKeys.searchHistory) ?? [];
  }

  void _saveSearchHistory() {
    _prefs?.setStringList(PrefKeys.searchHistory, _searchHistory);
  }
}
