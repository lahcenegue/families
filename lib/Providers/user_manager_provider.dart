import 'package:families/Apis/get_family_stores_api.dart';
import 'package:families/Utils/Constants/api_methods.dart';
import 'package:flutter/material.dart';

import '../Apis/get_banner_images.dart';
import '../Models/banner_images.dart';
import '../Models/request_model.dart';
import '../Models/store_model.dart';
import '../View_models/families_store_viewmodel.dart';

enum StoreType { popular, all }

class UserManagerProvider extends ChangeNotifier {
  bool isApiCallProcess = false;
  List<String>? bannerImages;
  FamiliesStoreViewModel? popularFamiliesViewModel;
  FamiliesStoreViewModel? allFamiliesViewModel;
  StoreItemViewModel? _selectedStore;
  DishItemViewModel? _selectedDish;

  UserManagerProvider() {
    _initialize();
  }

  StoreItemViewModel? get selectedStore => _selectedStore;
  DishItemViewModel? get selectedDish => _selectedDish;

  Future<void> _initialize() async {
    isApiCallProcess = true;
    notifyListeners();
    await getBannerImages();
    await getFamilyStores(StoreType.popular);
    await getFamilyStores(StoreType.all);
    isApiCallProcess = false;
    notifyListeners();
  }

  Future<void> getBannerImages() async {
    try {
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

  Future<void> getFamilyStores(StoreType type) async {
    RequestModel requestModel = RequestModel(
      method: type == StoreType.popular
          ? ApiMethods.getPopularFamilies
          : ApiMethods.getAllFamilies,
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
}
