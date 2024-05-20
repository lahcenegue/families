import 'base_response_model.dart';

class RegisterResponseModel extends BaseResponseModel {
  final RegisterUserData? userData;

  RegisterResponseModel({super.status, super.errorCode, this.userData});
  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      status: json['status'] as String?,
      errorCode: json['error_code'] ?? -1,
      userData:
          json['data'] != null ? RegisterUserData.fromJson(json['data']) : null,
    );
  }
}

class RegisterUserData {
  String? otpToken;
  String? phoneNumber;
  String? userName;
  String? accountType;

  RegisterUserData({
    this.otpToken,
    this.userName,
    this.accountType,
    this.phoneNumber,
  });

  factory RegisterUserData.fromJson(Map<String, dynamic> json) {
    return RegisterUserData(
      phoneNumber: json['PhoneNumber'].toString(),
      userName: json['UserName'].toString(),
      accountType: json['AccountType'].toString(),
      otpToken: json['OtpToken'].toString(),
    );
  }
}
