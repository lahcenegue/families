import 'base_response_model.dart';

class BaseModel extends BaseResponseModel {
  BaseModel({
    super.status,
  });
  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      status: json['status'].toString(),
    );
  }
}
