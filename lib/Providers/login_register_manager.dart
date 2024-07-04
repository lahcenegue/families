import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
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

enum OTPType { confirm, reset }

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

  File? storeImage;
  String storeImageBase64 = '';
  File? medicalCertificate;
  String medicalCertificateBase64 = '';

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();

  RequestModel loginRequestModel = RequestModel();
  RequestModel registerRequestModel = RequestModel();
  RequestModel otpRequestModel = RequestModel();
  RequestModel resetRequestModel = RequestModel();

  String storeClassification = 'حلويات';
  String? checkPassrowd;

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

    await _setApiCallProcess(true);

    try {
      registerRequestModel.method = ApiMethods.register;
      registerRequestModel.accountType = accountType;

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

  void firstPasword(String value) {
    checkPassrowd = value;
    notifyListeners();
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

  Future<void> pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      storeImage = File(image.path);
      Uint8List storeImageBytes = await storeImage!.readAsBytes();
      String mimeType = lookupMimeType(storeImage!.path) ?? 'image/jpeg';
      String base64Image = base64Encode(storeImageBytes);

      storeImageBase64 = 'data:$mimeType;base64,$base64Image';
      registerRequestModel.storeImage = storeImageBase64;

      notifyListeners();
    }
  }

  Future<void> pickMedicalCertificate() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      medicalCertificate = File(image.path);
      Uint8List medicalCertificateBytes =
          await medicalCertificate!.readAsBytes();
      String mimeType = lookupMimeType(medicalCertificate!.path) ??
          'application/octet-stream';
      String base64Image = base64Encode(medicalCertificateBytes);

      medicalCertificateBase64 = 'data:$mimeType;base64,$base64Image';
      registerRequestModel.document = medicalCertificateBase64;
      notifyListeners();
    }
  }

  // Future<void> selectLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   String address = await _getAddressFromCoordinates(
  //     position.latitude,
  //     position.longitude,
  //   );
  //   locationController.text = address;
  //   notifyListeners();
  // }

  // Future<String> _getAddressFromCoordinates(
  //     double latitude, double longitude) async {
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(latitude, longitude);
  //   if (placemarks.isNotEmpty) {
  //     final Placemark place = placemarks.first;
  //     return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
  //   }
  //   return "Unknown location";
  // }

  Future<void> saveUserData(dynamic value) async {
    print('save data after login ${value.userData!.token}');
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
    if (accountType == AppStrings.user) {
      NavigationService.navigateTo(AppRoutes.userHomeScreen);
    } else {
      NavigationService.navigateTo(AppRoutes.familyHomeScreen);
    }
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
