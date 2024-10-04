import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/add_to_favorite.dart';
import '../Apis/base_api.dart';
import '../Apis/get_banner_images.dart';
import '../Apis/get_dish_review_api.dart';
import '../Apis/get_family_stores_api.dart';
import '../Apis/get_my_orders.dart';
import '../Models/banner_images.dart';
import '../Models/base_model.dart';
import '../Models/dish_review_model.dart';
import '../Models/my_ordres_model.dart';
import '../Models/request_model.dart';
import '../Models/store_model.dart';
import '../Utils/Constants/api_methods.dart';
import '../Utils/Constants/app_strings.dart';
import '../View_models/dish_review_viewmodel.dart';
import '../View_models/families_store_viewmodel.dart';
import '../View_models/my_ordres_viewmodel.dart';

enum StoreType { popular, all }

class UserManagerProvider extends ChangeNotifier {
  SharedPreferences? prefs;

  bool isApiCallProcess = false;
  bool isDataInitialized = false;
  bool isLoading = false;
  bool isLoggedIn = false;

  String? errorMessage;

  List<String>? bannerImages;
  FamiliesStoreViewModel? popularFamiliesViewModel;
  FamiliesStoreViewModel? allFamiliesViewModel;
  FamiliesStoreViewModel? favoriteFamiliesViewModel;
  DishReviewViewModel? dishReviewViewModel;
  MyOrdersViewModel? myOrders;

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
    isApiCallProcess = true;
    errorMessage = null;
    isDataInitialized = false;
    notifyListeners();

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        prefs = await SharedPreferences.getInstance();
        token = prefs!.getString(PrefKeys.token);
        isLoggedIn = token != null;

        await getBannerImages();
        await fetchAllFamilyData();

        if (token != null) {
          await fetchMyOrders();
        }

        isDataInitialized = true;
        errorMessage = null;
      } else {
        throw const SocketException('No Internet connection');
      }
    } on SocketException catch (_) {
      print('No Internet connection');
      errorMessage =
          'No Internet connection. Please check your network settings and try again.';
      isDataInitialized = false;
    } catch (e) {
      print('Error initializing data: $e');
      errorMessage = 'Error loading data. Please try again.';
      isDataInitialized = false;
    } finally {
      isApiCallProcess = false;
      notifyListeners();
    }
  }

  Future<bool> checkLoginStatus() async {
    if (isLoggedIn) return true;

    return false;
  }

  // Get Banner Images =============================================
  Future<void> getBannerImages() async {
    try {
      BannerImagesModel value = await getBannerImagesApi(
        getBannerRequest: RequestModel(method: ApiMethods.getBannerMethod),
      );

      if (value.status == 'Success') {
        bannerImages = value.data!;
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
    final String method = type == StoreType.popular
        ? ApiMethods.getPopularFamilies
        : ApiMethods.getAllFamilies;

    RequestModel requestModel = RequestModel(
      method: method,
      token: token,
    );

    try {
      isLoading = true;
      notifyListeners();

      StoreModel storeModel =
          await getFamilyStoresApi(getFamilyStoresRequest: requestModel);

      if (storeModel.status == 'Success' && storeModel.data != null) {
        final viewModel = FamiliesStoreViewModel(storeModel: storeModel);

        if (type == StoreType.popular) {
          popularFamiliesViewModel = viewModel;
        } else {
          allFamiliesViewModel = viewModel;
        }
      } else {
        throw Exception(
            'Failed to fetch ${type == StoreType.popular ? 'popular' : 'all'} family stores. Status: ${storeModel.status}');
      }
    } on SocketException catch (_) {
      errorMessage =
          'No Internet connection. Please check your network settings and try again.';
    } catch (e) {
      print(
          'Error fetching ${type == StoreType.popular ? 'popular' : 'all'} family stores: $e');
      errorMessage = 'Error fetching data. Please try again.';
    } finally {
      isLoading = false;
      if (errorMessage != null) {
        final emptyViewModel =
            FamiliesStoreViewModel(storeModel: StoreModel(data: []));
        if (type == StoreType.popular) {
          popularFamiliesViewModel = emptyViewModel;
        } else {
          allFamiliesViewModel = emptyViewModel;
        }
      }
      notifyListeners();
    }
  }

  Future<void> fetchAllFamilyData() async {
    await getFamilyStores(StoreType.popular);
    await getFamilyStores(StoreType.all);
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

  Future<void> fetchMyFavoriteStores() async {
    print('fetch favorite stores ================');
    RequestModel requestModel = RequestModel(
      method: ApiMethods.getFavoriteStores,
      token: token,
    );

    try {
      isApiCallProcess = true;
      notifyListeners();

      StoreModel storeModel =
          await getFamilyStoresApi(getFamilyStoresRequest: requestModel);

      if (storeModel.status == 'Success') {
        final viewModel = FamiliesStoreViewModel(storeModel: storeModel);
        favoriteFamiliesViewModel = viewModel;
      }
    } catch (e) {
      print('error fetch favorite list $e');
    } finally {
      isApiCallProcess = false;
      notifyListeners();
    }
  }

  Future<void> fetchMyOrders() async {
    print('fetch my orders');
    RequestModel requestModel = RequestModel(
      method: ApiMethods.getMyOrders,
      token: token,
    );

    try {
      MyOrdersModel value =
          await getMyOrdersApi(getMyOredesRequest: requestModel);
      if (value.status == 'Success') {
        myOrders = MyOrdersViewModel(responseModel: value);
        notifyListeners();
      } else {
        print('Failed to fetch my ordres');
      }
    } catch (e) {
      print('Error fetching my orders: $e');
    }
  }

  Future<String?> fulfillOrder(int cartItemId) async {
    String? message;
    RequestModel requestModel = RequestModel(
      method: ApiMethods.fulfillOder,
      cartItemId: cartItemId,
      token: token,
    );
    try {
      isApiCallProcess = true;
      notifyListeners();

      BaseModel value = await baseApi(requestModel: requestModel);

      if (value.status == 'Success') {
        message = 'تم استلام طلبك بنجاح';
        return message;
      } else {
        message = 'حدث خطأ في عملية الاستلام يرجى اعادة المحاولة';
        return message;
      }
    } catch (e) {
      print('error fulfill order $e');
    } finally {
      isApiCallProcess = false;
      notifyListeners();
    }
    return message;
  }

  // Future<void> reset() async {
  //   isApiCallProcess = false;
  //   isDataInitialized = false;
  //   isLoading = false;
  //   isLoggedIn = false;
  //   errorMessage = null;
  //   bannerImages = null;
  //   popularFamiliesViewModel = null;
  //   allFamiliesViewModel = null;
  //   dishReviewViewModel = null;
  //   selectedRating = 0;
  //   _selectedStore = null;
  //   _selectedDish = null;
  //   token = null;
  //   notifyListeners();
  //   initializeData();
  // }
}
