import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:families/Utils/Helprs/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Constants/app_strings.dart';

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
  bool isVisible2 = false;
  bool isAgree = false;
  int _seconds = 60;

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

  int get seconds => _seconds;

  void toggleAccountType(String type) {
    accountType = type;
    notifyListeners();
    if (_prefs!.getString(PrefKeys.onBording) == null) {
      NavigationService.navigateTo(AppRoutes.onBordingScreen);
    } else {
      NavigationService.navigateTo(AppRoutes.loginScreen);
    }
  }

  void togglePasswordVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void togglePassword2Visibility() {
    isVisible2 = !isVisible2;
    notifyListeners();
  }

  void toggleIsAgree(bool value) {
    isAgree = value;
    notifyListeners();
  }

  // Future<void> pickImageFromCamera() async {
  //   final ImagePicker picker = ImagePicker();
  //   XFile? image = await picker.pickImage(source: ImageSource.camera);

  //   storeImage = File(image!.path);
  //   Uint8List storeImagebytes = storeImage!.readAsBytesSync();
  //   storeImageBase64 = base64Encode(storeImagebytes);
  //   notifyListeners();
  // }

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    storeImage = File(image!.path);
    Uint8List storeImagebytes = storeImage!.readAsBytesSync();
    storeImageBase64 = base64Encode(storeImagebytes);
    notifyListeners();
  }

  // Future<void> uploadImages() async {
  //   final pickedFile = await ImagePicker().pickMultiImage();
  //   List<XFile> xfilePick = pickedFile;

  //   if (xfilePick.isNotEmpty) {
  //     for (var i = 0; i < xfilePick.length; i++) {
  //       selectedImages.add(File(xfilePick[i].path));
  //     }

  //     Uint8List imagebytes = selectedImages[mainImage].readAsBytesSync();

  //     mainImageBase64 = base64Encode(imagebytes);
  //     // addAdsRequest.image = mainImageBase64;
  //     notifyListeners();
  //   } else {
  //     //Get.snackbar(AppStrings.appName, 'لم يتم اختيار الصور');
  //   }
  // }

  void startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
        notifyListeners();
      } else {
        _timer.cancel(); // Stop the timer when it reaches 0 seconds
      }
    });
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
