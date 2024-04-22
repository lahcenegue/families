import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:families/Apis/login_api.dart';
import 'package:families/Models/login_response_model.dart';
import 'package:families/Utils/Constants/api_methods.dart';
import 'package:families/Utils/Helprs/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/base_api.dart';
import '../Models/base_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/app_strings.dart';

enum AccountType { user, admin }

enum OTPType { confirm, reset }

enum VisibilityField { password, password2 }

class LoginAndRegisterManager extends ChangeNotifier {
  SharedPreferences? _prefs;
  Timer? _timer;

  bool isApiCallProcess = false;
  bool isVisible = false;
  bool isVisible2 = false;
  bool isAgree = false;

  String accountType = AppStrings.user;
  OTPType otpType = OTPType.confirm;
  int _seconds = 60;

  // pick Image
  //List<File> selectedImages = [];
  File? storeImage;
  String storeImageBase64 = '';

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();

  RequestModel loginRequestModel = RequestModel();
  RequestModel otpRequestModel = RequestModel();

  //

  LoginAndRegisterManager() {
    _initPrefs();
  }

  @override
  void dispose() {
    if (_timer?.isActive ?? false) {
      _timer!.cancel();
    }
    super.dispose();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  int get seconds => _seconds;

  //Login function
  Future<String?> login() async {
    if (!validateAndSave(ApiMethods.login)) return null;
    isApiCallProcess = true;
    notifyListeners();

    try {
      loginRequestModel.method = ApiMethods.login;
      loginRequestModel.accountType = accountType;

      LoginResponseModel value =
          await loginApi(loginRequestModel: loginRequestModel);

      if (value.status == 'success') {
        isApiCallProcess = false;
        loginRequestModel = RequestModel();
        notifyListeners();
        await saveUserData(value);
        NavigationService.navigateTo(AppRoutes.userHomeScreen);
        return 'succes';
      } else {
        isApiCallProcess = false;
        notifyListeners();
        return 'error';
      }
    } catch (e) {
      isApiCallProcess = false;
      notifyListeners();
    } finally {
      if (!isApiCallProcess) {
        isApiCallProcess = false;
        notifyListeners();
      }
    }
  }

  //Send OTP for reset password
  Future<void> sendOTPForResetPassword() async {
    isApiCallProcess = true;
    otpType = OTPType.reset;
    notifyListeners();
    try {
      otpRequestModel.method = ApiMethods.restPasswordOtp;
      otpRequestModel.accountType = accountType;
      BaseModel value = await baseApi(requestModel: otpRequestModel);
      if (value.status == 'success') {
        otpRequestModel = RequestModel();

        isApiCallProcess = false;
        notifyListeners();
        NavigationService.navigateTo(AppRoutes.otpScreen);
        startTimer();
      } else {
        isApiCallProcess = false;
        notifyListeners();
      }
    } catch (e) {
      isApiCallProcess = false;
      notifyListeners();
    } finally {
      if (!isApiCallProcess) {
        isApiCallProcess = false;
        notifyListeners();
      }
    }
  }

  // Confirem OTP code
  Future<void> confirmOTP() async {
    isApiCallProcess = true;
    notifyListeners();
    try {
      otpRequestModel.method = ApiMethods.confirmOtp;
    } catch (e) {
      isApiCallProcess = false;
      notifyListeners();
    } finally {
      if (!isApiCallProcess) {
        isApiCallProcess = false;
        notifyListeners();
      }
    }
  }

  void toggleAccountType(String type) {
    accountType = type;
    notifyListeners();
    if (_prefs!.getString(PrefKeys.onBording) == null) {
      NavigationService.navigateTo(AppRoutes.onBordingScreen);
    } else {
      NavigationService.navigateTo(AppRoutes.loginScreen);
    }
  }

  void toggleVisibility({required int fieldIndex}) {
    if (fieldIndex == 1) {
      isVisible = !isVisible;
    } else if (fieldIndex == 2) {
      isVisible2 = !isVisible2;
    }
    notifyListeners();
  }

  void toggleIsAgree(bool value) {
    isAgree = value;
    notifyListeners();
  }

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      storeImage = File(image.path);
      Uint8List storeImageBytes = await storeImage!.readAsBytes();
      storeImageBase64 = base64Encode(storeImageBytes);
      notifyListeners();
    }
  }

  Future<void> saveUserData(dynamic value) async {
    await _prefs!.setString(PrefKeys.token, value.userData.token!);
    await _prefs!.setString(PrefKeys.userName, value.userData.userName!);
    await _prefs!.setString(PrefKeys.email, value.userData.email!);
    await _prefs!.setString(PrefKeys.phoneNumber, value.userData.phoneNumber!);
  }

  void startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
        notifyListeners();
      } else {
        _timer?.cancel();
      }
    });
  }

  bool validateAndSave(String formKey) {
    final FormState? form = formKey == ApiMethods.register
        ? registerFormKey.currentState
        : loginFormKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

  // Future<void> pickImageFromCamera() async {
  //   final ImagePicker picker = ImagePicker();
  //   XFile? image = await picker.pickImage(source: ImageSource.camera);

  //   storeImage = File(image!.path);
  //   Uint8List storeImagebytes = storeImage!.readAsBytesSync();
  //   storeImageBase64 = base64Encode(storeImagebytes);
  //   notifyListeners();
  // }

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
