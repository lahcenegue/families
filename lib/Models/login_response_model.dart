import 'base_response_model.dart';

class LoginResponseModel extends BaseResponseModel {
  final LoginUserData? userData;

  LoginResponseModel({super.status, this.userData});
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'] as String?,
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
