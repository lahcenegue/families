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
  String? email;
  String? token;

  LoginUserData({
    this.token,
    this.userName,
    this.email,
    this.phoneNumber,
  });

  factory LoginUserData.fromJson(Map<String, dynamic> json) {
    return LoginUserData(
      phoneNumber: json['PhoneNumber'].toString(),
      userName: json['UserName'].toString(),
      email: json['Email'].toString(),
      token: json['Token'].toString(),
    );
  }
}
