import 'dart:async';

import 'package:families/Apis/get_family_stores_api.dart';
import 'package:families/Utils/Constants/api_methods.dart';
import 'package:families/Utils/Constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/add_to_favorite.dart';
import '../Apis/get_banner_images.dart';
import '../Apis/get_dish_review_api.dart';
import '../Apis/search_api.dart';
import '../Models/banner_images.dart';
import '../Models/base_model.dart';
import '../Models/dish_review_model.dart';
import '../Models/request_model.dart';
import '../Models/search_model.dart';
import '../Models/store_model.dart';
import '../View_models/dish_review_viewmodel.dart';
import '../View_models/families_store_viewmodel.dart';
import '../View_models/search_view_model.dart';

enum StoreType { popular, all }

class UserManagerProvider extends ChangeNotifier {
  SharedPreferences? _prefs;

  TextEditingController searchController = TextEditingController();

  bool isApiCallProcess = false;
  bool isDataInitialized = false;
  bool isLoading = false;
  bool isSearching = false;

  String? errorMessage;

  String filterOption = 'family';

  List<String>? bannerImages;
  FamiliesStoreViewModel? popularFamiliesViewModel;
  FamiliesStoreViewModel? allFamiliesViewModel;
  SearchViewModel? searchViewModel;
  DishReviewViewModel? dishReviewViewModel;
  List<String> _searchHistory = [];
  Timer? debounce;
  int selectedRating = 0;

  StoreItemViewModel? _selectedStore;
  DishItemViewModel? _selectedDish;

  String? token;
  int currentQuantity = 1;

  UserManagerProvider() {
    initializeData();
  }

  StoreItemViewModel? get selectedStore => _selectedStore;
  DishItemViewModel? get selectedDish => _selectedDish;
  List<String> get searchHistory => _searchHistory;

  Future<void> initializeData() async {
    if (!isDataInitialized) {
      isApiCallProcess = true;
      notifyListeners();

      _prefs = await SharedPreferences.getInstance();
      token = _prefs!.getString(PrefKeys.token);
      print('=============== User Manager $token =================');

      await getBannerImages();
      await getFamilyStores(StoreType.popular);
      await getFamilyStores(StoreType.all);

      _loadSearchHistory();

      isApiCallProcess = false;
      isDataInitialized = true;
      notifyListeners();
    }
  }

  void onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      search(query: query);
    });
  }

  Future<void> search({required String query}) async {
    print('search ===============');
    if (query.isEmpty) {
      searchViewModel = null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
      return;
    }

    isLoading = true;
    addSearchWord(query);

    RequestModel requestModel = RequestModel(
      method: ApiMethods.searchMethode,
      query: query,
    );

    try {
      SearchModel searchModel = await searchApi(searchRequest: requestModel);

      if (searchModel.status == 'Success') {
        searchViewModel = SearchViewModel(searchModel: searchModel);
      } else {
        searchViewModel = null;
        print('Failed to fetch search results');
      }
    } catch (e) {
      searchViewModel = null;
      print('Error fetching search results: $e');
    } finally {
      print('finaly ========================');
      isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  Future<void> getBannerImages() async {
    try {
      print('========== get banner images ==================');
      BannerImagesModel value = await getBannerImagesApi(
        getBannerRequest: RequestModel(method: ApiMethods.getBannerMethod),
      );

      print(value.status);
      if (value.status == 'Success') {
        bannerImages = value.data!;
        print(value.data);
        notifyListeners();
      } else {
        print('Failed to fetch banner images');
      }
    } catch (e) {
      print('Error fetching banner images: $e');
    }
  }

  Future<int?> addToFavorite({required int storeId}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    RequestModel requestModel = RequestModel(
      method: ApiMethods.addToFavorite,
      token: token,
      storeId: storeId,
    );

    try {
      BaseModel value = await addToFavoriteApi(favoriteRequest: requestModel);

      if (value.status == 'Success') {
        print('Item added to favorites successfully');
        return null;
      } else {
        print('Failed to add item to favorites');
        return value.errorCode;
      }
    } catch (e) {
      errorMessage = 'Error adding item to favorites: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<void> getFamilyStores(StoreType type) async {
    RequestModel requestModel = RequestModel(
      method: type == StoreType.popular
          ? ApiMethods.getPopularFamilies
          : ApiMethods.getAllFamilies,
      token: token,
    );

    try {
      StoreModel storeModel =
          await getFamilyStoresApi(getFamilyStoresRequest: requestModel);

      if (storeModel.status == 'Success') {
        if (type == StoreType.popular) {
          popularFamiliesViewModel =
              FamiliesStoreViewModel(storeModel: storeModel);
        } else {
          allFamiliesViewModel = FamiliesStoreViewModel(storeModel: storeModel);
        }
        notifyListeners();
      } else {
        print(
            'Failed to fetch ${type == StoreType.popular ? 'popular' : 'all'} family stores');
      }
    } catch (e) {
      print('Error fetching family stores: $e');
    }
  }

  void setSelectedStore(StoreItemViewModel store) {
    _selectedStore = store;
    notifyListeners();
  }

  void setSelectedDish(DishItemViewModel dish) {
    _selectedDish = dish;
    notifyListeners();
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

  void incrementQuantity() {
    currentQuantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (currentQuantity > 1) {
      currentQuantity--;
      notifyListeners();
    }
  }

  Future<void> getDishReviews({required int itemID}) async {
    print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    RequestModel requestModel = RequestModel(
      method: ApiMethods.dishReviews,
      token: token,
      itemId: itemID,
    );

    try {
      DishReviewModel dishReviewModel =
          await getDishReviewsApi(request: requestModel);

      if (dishReviewModel.status == 'Success') {
        dishReviewViewModel =
            DishReviewViewModel(dishReviewModel: dishReviewModel);
        notifyListeners();
      } else {
        print('Failed to fetch dish reviews');
      }
    } catch (e) {
      print('Error fetching dish reviews: $e');
    }
  }

  void setSelectedRating(int rating) {
    selectedRating = rating;
    notifyListeners();
  }

  List<DishReviewItemViewModel> get filteredReviews {
    if (dishReviewViewModel == null) return [];
    if (selectedRating == 0) return dishReviewViewModel!.items;
    return dishReviewViewModel!.items
        .where((review) => review.rating == selectedRating)
        .toList();
  }
}
