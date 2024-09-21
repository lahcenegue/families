import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/add_dish_api.dart';
import '../Apis/get_my_dishs.dart';
import '../Apis/get_my_orders.dart';
import '../Models/add_dish_mode.dart';
import '../Models/my_dishs_model.dart';
import '../Models/my_ordres_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/api_methods.dart';
import '../Utils/Constants/app_strings.dart';
import '../View_models/my_dishs_viewmodel.dart';
import '../View_models/my_ordres_viewmodel.dart';

class FamilyManagerProvider extends ChangeNotifier {
  SharedPreferences? prefs;
  bool isApiCallProcess = false;
  bool isDataInitialized = false;

  String? token;

  MyOrdersViewModel? myOrders;
  MyDishsViewmodel? myDishs;

  File? dishImage;
  String dishImageBase64 = '';

  double? preparationTime;

  final GlobalKey<FormState> addDishFormKey = GlobalKey<FormState>();

  RequestModel addDishRequestModel = RequestModel();

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

  Future<void> fetchMyDishs() async {
    RequestModel requestModel = RequestModel(
      method: ApiMethods.getMyDishs,
      token: token,
    );

    try {
      MyDishsModel value = await getMyDishsApi(getItemsRequest: requestModel);
      if (value.status == 'Success') {
        myDishs = MyDishsViewmodel(myDishsModel: value);
        notifyListeners();
      } else {
        print('Failed to fetch my dhishs');
      }
    } catch (e) {
      print('Error fetching my dishs: $e');
    }
  }

  Future<void> addNewDishFunction() async {
    isApiCallProcess = true;
    notifyListeners();
    addDishRequestModel.method = ApiMethods.addNewDish;
    addDishRequestModel.token = token;
    addDishRequestModel.preparationTime = preparationTime;

    try {
      AddDishModel response =
          await addDishApi(addDishRequest: addDishRequestModel);
      if (response.status == 'Success') {
        await fetchMyDishs();
        notifyListeners();
      } else {
        print('Failed to add dish');
      }
    } catch (e) {
      print('Error adding dish: $e');
    } finally {
      isApiCallProcess = false;
      notifyListeners();
    }
  }

  Future<void> pickPDishImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      dishImage = File(image.path);
      Uint8List dishImageBytes = await dishImage!.readAsBytes();
      String mimeType = lookupMimeType(dishImage!.path) ?? 'image/jpeg';
      String base64Image = base64Encode(dishImageBytes);

      dishImageBase64 = 'data:$mimeType;base64,$base64Image';
      addDishRequestModel.storeImage = dishImageBase64;

      notifyListeners();
    }
  }
}
