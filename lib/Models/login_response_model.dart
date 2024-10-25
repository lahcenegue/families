import 'base_response_model.dart';

class LoginResponseModel extends BaseResponseModel {
  final LoginUserData? userData;

  LoginResponseModel({super.status, super.errorCode, this.userData});
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'] as String?,
      errorCode: json['error_code'] ?? -1,
      userData:
          json['data'] != null ? LoginUserData.fromJson(json['data']) : null,
    );
  }
}

class LoginUserData {
  String? phoneNumber;
  String? userName;
  String? token;
  String? otpToken;
  String? accountType;
  String? storeName;
  String? location;
  String? image;
  int? active;

  LoginUserData({
    this.token,
    this.otpToken,
    this.userName,
    this.phoneNumber,
    this.accountType,
    this.storeName,
    this.location,
    this.image,
    this.active,
  });

  factory LoginUserData.fromJson(Map<String, dynamic> json) {
    return LoginUserData(
      phoneNumber: json['PhoneNumber'].toString(),
      userName: json['UserName'].toString(),
      token: json['Token'].toString(),
      otpToken: json['OtpToken'],
      accountType: json['AccountType'].toString(),
      storeName: json['StoreName'].toString(),
      location: json['Location'].toString(),
      image: json['Image'].toString(),
      active: json['active'],
    );
  }
}
