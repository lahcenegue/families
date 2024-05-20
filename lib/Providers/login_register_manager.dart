import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/base_api.dart';
import '../Apis/get_rest_token_api.dart';
import '../Apis/login_api.dart';
import '../Apis/register_api.dart';
import '../Models/base_model.dart';
import '../Models/get_reset_token_model.dart';
import '../Models/login_response_model.dart';
import '../Models/register_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/api_methods.dart';
import '../Utils/Constants/app_strings.dart';
import '../Utils/Helprs/navigation_service.dart';

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
  String? otpToken;
  int _seconds = 60;

  // pick Image
  //List<File> selectedImages = [];
  File? storeImage;
  String storeImageBase64 = '';

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();

  RequestModel loginRequestModel = RequestModel();
  RequestModel registerRequestModel = RequestModel();
  RequestModel otpRequestModel = RequestModel();
  RequestModel resetRequestModel = RequestModel();

  //

  LoginAndRegisterManager() {
    _initPrefs();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int get seconds => _seconds;
  bool get isPrefsInitialized => _prefs != null;

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  //Login function
  Future<int?> login() async {
    if (!validateAndSave(loginFormKey)) return null;
    await _setApiCallProcess(true);

    try {
      loginRequestModel.method = ApiMethods.login;
      loginRequestModel.accountType = accountType;

      LoginResponseModel value =
          await loginApi(loginRequestModel: loginRequestModel);

      if (value.status == 'success') {
        await _handleSuccessfulLogin(value);
        return null;
      } else {
        return value.errorCode;
      }
    } catch (e) {
      return -1;
    } finally {
      await _setApiCallProcess(false);
    }
  }

  Future<int?> register() async {
    if (!isAgree) return 10;
    if (!validateAndSave(registerFormKey)) return null;

    print('register function');
    await _setApiCallProcess(true);

    try {
      registerRequestModel.method = ApiMethods.register;
      registerRequestModel.accountType = accountType;
      registerRequestModel.email = 'test@test.com'; //TODO delete

      RegisterResponseModel value =
          await registerApi(registerRequestModel: registerRequestModel);

      if (value.status == 'success') {
        otpToken = value.userData!.otpToken;
        NavigationService.navigateTo(AppRoutes.otpScreen);
        startTimer();
        await sendOtpForCreateAccount();
        return null;
      } else {
        return value.errorCode;
      }
    } catch (e) {
      return -1;
    } finally {
      await _setApiCallProcess(false);
    }
  }

  Future<void> lougOut() async {
    if (!isPrefsInitialized) {
      await _initPrefs();
    }

    if (_prefs != null) {
      await _prefs!.remove(PrefKeys.accountType);
      await _prefs!.remove(PrefKeys.token);
      await _prefs!.remove(PrefKeys.userName);
      await _prefs!.remove(PrefKeys.phoneNumber);
      NavigationService.navigateToAndReplace(AppRoutes.accountTypeScreen);
    } else {
      print('Error: SharedPreferences _prefs is null.');
    }
  }

  // send otp for create account
  Future<int?> sendOtpForCreateAccount() async {
    print('send otp code ======');
    otpType = OTPType.confirm;
    await _setApiCallProcess(true);

    try {
      otpRequestModel.method = ApiMethods.sedOtp;
      otpRequestModel.otpToken = otpToken;

      BaseModel value = await baseApi(requestModel: otpRequestModel);

      if (value.status == 'success') {
        otpRequestModel = RequestModel();
        startTimer();
        return null;
      } else {
        return value.errorCode;
      }
    } catch (e) {
      return -1;
    } finally {
      await _setApiCallProcess(false);
    }
  }

  // Confirem OTP code
  Future<int?> confirmOTP() async {
    await _setApiCallProcess(true);

    try {
      otpRequestModel.method = ApiMethods.confirmOtp;
      otpRequestModel.otpToken = otpToken!;

      LoginResponseModel value =
          await loginApi(loginRequestModel: otpRequestModel);

      if (value.status == 'success') {
        await _handleSuccessfulLogin(value);
        NavigationService.navigateToAndReplace(AppRoutes.congratulationsScreen);
        return null;
      } else {
        return value.errorCode;
      }
    } catch (e) {
      return -1;
    } finally {
      await _setApiCallProcess(false);
    }
  }

  //Send OTP for reset password
  Future<void> sendOTPForResetPassword() async {
    await _setApiCallProcess(true);
    otpType = OTPType.reset;

    try {
      otpRequestModel.method = ApiMethods.restPasswordOtp;
      otpRequestModel.accountType = accountType;

      BaseModel value = await baseApi(requestModel: otpRequestModel);

      if (value.status == 'success') {
        NavigationService.navigateTo(AppRoutes.otpScreen);
        startTimer();
      }
    } catch (e) {
      // handle error
    } finally {
      await _setApiCallProcess(false);
    }
  }

  //Send OTP for reset password
  Future<void> getResetToken() async {
    await _setApiCallProcess(true);

    try {
      otpRequestModel.method = ApiMethods.getResetToken;
      otpRequestModel.accountType = accountType;

      ResetTokenResponseModel value =
          await getResetTokenApi(requestModel: otpRequestModel);

      if (value.status == 'success') {
        otpRequestModel = RequestModel();
        resetRequestModel.resetToken = value.data!.resetToken;
        NavigationService.navigateTo(AppRoutes.resetPasswordScreen);
      }
    } catch (e) {
      // handle error
    } finally {
      await _setApiCallProcess(false);
    }
  }

  //Reset password
  Future<int?> resetPassword() async {
    if (!validateAndSave(resetFormKey)) return null;
    await _setApiCallProcess(true);

    try {
      resetRequestModel.method = ApiMethods.resetPassword;

      LoginResponseModel value =
          await loginApi(loginRequestModel: resetRequestModel);

      if (value.status == 'success') {
        resetRequestModel = RequestModel();
        await _handleSuccessfulLogin(value);
        if (value.userData!.accountType == AppStrings.user) {
          await NavigationService.navigateToAndReplace(
              AppRoutes.userHomeScreen);
        } else {
          await NavigationService.navigateToAndReplace(
              AppRoutes.familyHomeScreen);
        }
        return null;
      } else {
        return value.errorCode;
      }
    } catch (e) {
      return -1;
    } finally {
      await _setApiCallProcess(false);
    }
  }

  void toggleAccountType(String type) {
    accountType = type;
    notifyListeners();
    _prefs!.setString(PrefKeys.accountType, type);

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

  bool validateAndSave(GlobalKey<FormState> formKey) {
    final FormState? form = formKey.currentState;

    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _setApiCallProcess(bool value) async {
    isApiCallProcess = value;
    notifyListeners();
  }

  Future<void> _handleSuccessfulLogin(LoginResponseModel value) async {
    isApiCallProcess = false;
    loginRequestModel = RequestModel();
    notifyListeners();
    await saveUserData(value);
    NavigationService.navigateTo(AppRoutes.userHomeScreen);
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
