import 'base_model.dart';

class BannerImagesModel extends BaseModel {
  final List<String>? data;
  BannerImagesModel({
    super.status,
    super.errorCode,
    this.data,
  });

  factory BannerImagesModel.fromJson(Map<String, dynamic> json) {
    return BannerImagesModel(
      status: json['status'].toString(),
      errorCode: json['error_code'] ?? -1,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList(),
    );
  }
}
