import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:families/Apis/get_all_messages.dart';
import 'package:families/Apis/get_my_dishs.dart';
import 'package:families/Models/my_dishs_model.dart';
import 'package:families/Models/my_ordres_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/add_dish_api.dart';
import '../Apis/get_my_orders.dart';
import '../Models/add_dish_mode.dart';
import '../Models/messages_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/api_methods.dart';
import '../View_models/messages_viewmodel.dart';
import '../View_models/my_dishs_viewmodel.dart';
import '../View_models/my_ordres_viewmodel.dart';

class FamilyManagerProvider extends ChangeNotifier {
  SharedPreferences? _prefs;
  bool isApiCallProcess = false;
  bool isDataInitialized = false;

  String? token;

  MyOrdersViewModel? myOrders;
  MyDishsViewmodel? myDishs;
  MessageViewModel? allMessages;

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

      _prefs = await SharedPreferences.getInstance();
      token = 'UfFqCtub4U';
      //token = _prefs!.getString(PrefKeys.token);

      await fetchMyOrders();
      await fetchMyDishs();
      await fetchMessages();

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

  Future<void> fetchMessages() async {
    RequestModel requestModel = RequestModel(
      method: ApiMethods.getAllMessages,
      token: token,
    );

    try {
      MessagesModel value = await getAllMessagesApi(requestModel: requestModel);
      if (value.status == 'Success') {
        allMessages = MessageViewModel(messageModel: value);
        notifyListeners();
      } else {
        print('Failed to fetch messages');
      }
    } catch (e) {
      print('Error fetching messages: $e');
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
