import 'base_response_model.dart';

class BaseModel extends BaseResponseModel {
  BaseModel({
    super.status,
    super.errorCode,
  });
  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      status: json['status'].toString(),
      errorCode: json['error_code'] ?? -1,
    );
  }
}
