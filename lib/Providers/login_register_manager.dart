import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:families/Constants/app_strings.dart';
import 'package:families/Widgets/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAndRegisterManager extends ChangeNotifier {
  SharedPreferences? _prefs;
  late Timer _timer;

  bool isApiCallProcess = false;
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  //
  String accountType = AppStrings.user;
  bool isVisible = false;

  // pick Image
  List<File> selectedImages = [];
  File? storeImage;
  String storeImageBase64 = '';
  int mainImage = 0;
  String mainImageBase64 = '';

  LoginAndRegisterManager() {
    _initPrefs();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  void toggleAccountType(String type) {
    accountType = type;
    notifyListeners();
    NavigationService.navigateTo(AppRoutes.loginScreen);
  }

  void togglePasswordVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  Future<void> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);

    storeImage = File(image!.path);
    Uint8List storeImagebytes = storeImage!.readAsBytesSync();
    storeImageBase64 = base64Encode(storeImagebytes);
    notifyListeners();
  }

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    storeImage = File(image!.path);
    Uint8List storeImagebytes = storeImage!.readAsBytesSync();
    storeImageBase64 = base64Encode(storeImagebytes);
    notifyListeners();
  }

  Future<void> uploadImages() async {
    final pickedFile = await ImagePicker().pickMultiImage();
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }

      Uint8List imagebytes = selectedImages[mainImage].readAsBytesSync();

      mainImageBase64 = base64Encode(imagebytes);
      // addAdsRequest.image = mainImageBase64;
      notifyListeners();
    } else {
      //Get.snackbar(AppStrings.appName, 'لم يتم اختيار الصور');
    }
  }

  bool validateAndSave(String formKey) {
    final FormState? form = formKey == 'register'
        ? registerFormKey.currentState
        : loginFormKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
