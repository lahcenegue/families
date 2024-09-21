import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/add_to_favorite.dart';
import '../Apis/get_banner_images.dart';
import '../Apis/get_dish_review_api.dart';
import '../Apis/get_family_stores_api.dart';
import '../Models/banner_images.dart';
import '../Models/base_model.dart';
import '../Models/dish_review_model.dart';
import '../Models/request_model.dart';
import '../Models/store_model.dart';
import '../Utils/Constants/api_methods.dart';
import '../Utils/Constants/app_strings.dart';
import '../View_models/dish_review_viewmodel.dart';
import '../View_models/families_store_viewmodel.dart';

enum StoreType { popular, all }

class UserManagerProvider extends ChangeNotifier {
  SharedPreferences? prefs;

  bool isApiCallProcess = false;
  bool isDataInitialized = false;
  bool isLoading = false;

  String? errorMessage;

  List<String>? bannerImages;
  FamiliesStoreViewModel? popularFamiliesViewModel;
  FamiliesStoreViewModel? allFamiliesViewModel;
  DishReviewViewModel? dishReviewViewModel;

  int selectedRating = 0;

  StoreItemViewModel? _selectedStore;
  DishItemViewModel? _selectedDish;

  String? token;

  UserManagerProvider() {
    initializeData();
  }

  StoreItemViewModel? get selectedStore => _selectedStore;
  DishItemViewModel? get selectedDish => _selectedDish;

  Future<void> initializeData() async {
    if (!isDataInitialized) {
      isApiCallProcess = true;
      notifyListeners();

      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString(PrefKeys.token);

      await getBannerImages();
      await getFamilyStores(StoreType.popular);
      await getFamilyStores(StoreType.all);

      isApiCallProcess = false;
      isDataInitialized = true;
      notifyListeners();
    }
  }

  // Get Banner Images =============================================
  Future<void> getBannerImages() async {
    try {
      BannerImagesModel value = await getBannerImagesApi(
        getBannerRequest: RequestModel(method: ApiMethods.getBannerMethod),
      );

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

  // Get Stores =========================================================
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

  void setSelectedStore(StoreItemViewModel store) {
    _selectedStore = store;
    notifyListeners();
  }

  void setSelectedDish(DishItemViewModel dish) {
    _selectedDish = dish;
    notifyListeners();
  }

  Future<void> getDishReviews({required int itemID}) async {
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
