import 'dart:convert' as convert;
import 'dart:io';
import 'dart:typed_data';

import 'package:families/Utils/Helprs/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/add_dish_api.dart';
import '../Apis/base_api.dart';
import '../Apis/get_my_dishs.dart';
import '../Apis/get_my_orders.dart';
import '../Apis/get_store_stats_api.dart';
import '../Apis/upload_image_api.dart';
import '../Models/add_dish_mode.dart';
import '../Models/base_model.dart';
import '../Models/my_dishs_model.dart';
import '../Models/my_ordres_model.dart';
import '../Models/request_model.dart';
import '../Models/store_stats_model.dart';
import '../Models/ulpoad_image_model.dart';
import '../Utils/Constants/api_methods.dart';
import '../Utils/Constants/app_strings.dart';
import '../View_models/my_dishs_viewmodel.dart';
import '../View_models/my_ordres_viewmodel.dart';
import '../View_models/store_stats_view_model.dart';

class FamilyManagerProvider extends ChangeNotifier {
  SharedPreferences? prefs;
  bool isApiCallProcess = false;
  bool isDataInitialized = false;

  String? token;

  MyOrdersViewModel? myOrders;
  MyDishsViewmodel? myDishs;
  StoreStatsViewModel? storeStatsViewModel;

  File? dishImage;
  List<String> uploadedImages = [];

  int? preparationTime;
  String? dishName;
  double? dishPrice;
  String? dishDescription;

  final GlobalKey<FormState> addDishFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editDishFormKey = GlobalKey<FormState>();

  FamilyManagerProvider() {
    initializeData();
  }

  Future<void> initializeData() async {
    if (!isDataInitialized) {
      isApiCallProcess = true;
      notifyListeners();

      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString(PrefKeys.token);

      await fetchMyOrders();
      await fetchMyDishs();
      await fetchStoreStats();

      isApiCallProcess = false;
      isDataInitialized = true;
      notifyListeners();
    }
  }

  Future<void> fetchMyOrders() async {
    RequestModel requestModel = RequestModel(
      method: ApiMethods.getMyOrders,
      token: token,
    );

    try {
      MyOrdersModel value =
          await getMyOrdersApi(getMyOredesRequest: requestModel);
      if (value.status == 'success') {
        myOrders = MyOrdersViewModel(responseModel: value);
        notifyListeners();
      } else {
        debugPrint('Failed to fetch my ordres');
      }
    } catch (e) {
      debugPrint('Error fetching my orders: $e');
    }
  }

  Future<void> fetchMyDishs() async {
    RequestModel requestModel = RequestModel(
      method: ApiMethods.getMyDishs,
      token: token,
    );

    try {
      MyDishsModel value = await getMyDishsApi(getItemsRequest: requestModel);
      if (value.status == 'success') {
        myDishs = MyDishsViewmodel(myDishsModel: value);
        notifyListeners();
      } else {
        debugPrint('Failed to fetch my dhishs');
      }
    } catch (e) {
      debugPrint('Error fetching my dishs: $e');
    }
  }

  Future<void> fetchStoreStats() async {
    RequestModel requestModel = RequestModel(
      method: ApiMethods.getStoreStats,
      token: token,
    );

    try {
      StoreStatsModel storeStats =
          await getStoreStatsApi(request: requestModel);
      storeStatsViewModel = StoreStatsViewModel(model: storeStats);
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching store stats: $e');
    }
  }

  Future<void> uploadImage() async {
    if (dishImage == null) return;

    isApiCallProcess = true;
    notifyListeners();

    try {
      Uint8List imageBytes = await dishImage!.readAsBytes();
      String mimeType = lookupMimeType(dishImage!.path) ?? 'image/jpeg';
      String base64Image = convert.base64Encode(imageBytes);
      String fullBase64 = 'data:$mimeType;base64,$base64Image';

      RequestModel uploadImageRequest = RequestModel(
        method: "upload_image",
        token: token,
        image: fullBase64,
      );

      UploadImageModel response =
          await uploadImageApi(uploadImageRequest: uploadImageRequest);

      if (response.status == 'success') {
        uploadedImages.add(response.data!.image!);
        notifyListeners();
      } else {
        debugPrint('Failed to upload image: ${response.errorCode}');
      }
    } catch (e) {
      debugPrint('Error uploading image: $e');
    } finally {
      isApiCallProcess = false;
      notifyListeners();
    }
  }

  Future<void> addNewDishFunction() async {
    if (addDishFormKey.currentState!.validate()) {
      isApiCallProcess = true;
      notifyListeners();

      try {
        RequestModel addDishRequest = RequestModel(
          method: ApiMethods.addNewDish,
          token: token,
          dishImages: uploadedImages,
          preparationTime: preparationTime,
          dishName: dishName,
          dishPrice: dishPrice,
          description: dishDescription,
        );

        AddDishModel response =
            await addDishApi(addDishRequest: addDishRequest);

        if (response.status == 'success') {
          await fetchMyDishs();
          clearDishData();
          NavigationService.navigateToAndReplace(AppRoutes.familyHomeScreen);
          notifyListeners();
        } else {
          debugPrint('Failed to add dish: ${response.errorCode}');
        }
      } catch (e) {
        debugPrint('Error adding dish: $e');
      } finally {
        isApiCallProcess = false;
        notifyListeners();
      }
    }
  }

  Future<void> editDishFunction(int dishId) async {
    if (editDishFormKey.currentState!.validate()) {
      isApiCallProcess = true;
      notifyListeners();

      try {
        RequestModel addDishRequest = RequestModel(
          method: ApiMethods.editDish,
          token: token,
          itemId: dishId,
          dishImages: uploadedImages,
          preparationTime: preparationTime,
          dishName: dishName,
          dishPrice: dishPrice,
          description: dishDescription,
        );

        AddDishModel response =
            await addDishApi(addDishRequest: addDishRequest);

        if (response.status == 'success') {
          await fetchMyDishs();
          clearDishData();
          NavigationService.navigateToAndReplace(AppRoutes.familyHomeScreen);
          notifyListeners();
        } else {
          debugPrint('Failed to edit dish: ${response.errorCode}');
        }
      } catch (e) {
        debugPrint('Error editing dish: $e');
      } finally {
        isApiCallProcess = false;
        notifyListeners();
      }
    }
  }

  void initEditDishData(MyDishViewModel dish) {
    dishName = dish.itemName;
    dishDescription = dish.description;
    dishPrice = dish.price;
    preparationTime = dish.preparationTime;
    uploadedImages = dish.images ?? [];
    notifyListeners();
  }

  Future<void> pickDishImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      dishImage = File(image.path);
      await uploadImage();
      notifyListeners();
    }
  }

  void clearDishData() {
    dishImage = null;
    uploadedImages.clear();
    preparationTime = null;
    dishName = null;
    dishPrice = null;
    dishDescription = null;
  }

  Future<void> deleteDish(int dishID) async {
    isApiCallProcess = true;
    notifyListeners();

    try {
      RequestModel deleteDishRequest = RequestModel(
        method: ApiMethods.deleteDish,
        token: token,
        itemId: dishID,
      );

      BaseModel value = await baseApi(requestModel: deleteDishRequest);
      if (value.status == 'Success') {
        await fetchMyDishs();
        notifyListeners();
      } else {
        debugPrint('Failed to delete dish: ${value.errorCode}');
      }
    } catch (e) {
      debugPrint('Error deleting dish: $e');
    } finally {
      isApiCallProcess = false;
      notifyListeners();
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
      BaseModel value = await baseApi(requestModel: requestModel);

      if (value.status == 'Success') {
        message = 'تم ارسال الطلب بنجاح';
        return message;
      } else {
        message = 'حدث خطأ في عملية الارسال يرجى اعادة المحاولة';
        return message;
      }
    } catch (e) {
      debugPrint('error fulfill order $e');
    }
    return message;
  }
}
