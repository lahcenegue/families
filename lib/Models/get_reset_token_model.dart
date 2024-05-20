import 'base_response_model.dart';

class ResetTokenResponseModel extends BaseResponseModel {
  final ResetTokenData? data;

  ResetTokenResponseModel({super.status, super.errorCode, this.data});

  factory ResetTokenResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetTokenResponseModel(
      status: json['status'] as String?,
      errorCode: json['error_code'] ?? -1,
      data: json['data'] != null ? ResetTokenData.fromJson(json['data']) : null,
    );
  }
}

class ResetTokenData {
  final String? resetToken;

  ResetTokenData({this.resetToken});

  factory ResetTokenData.fromJson(Map<String, dynamic> json) {
    return ResetTokenData(
      resetToken: json['ResetToken'] as String?,
    );
  }
}
