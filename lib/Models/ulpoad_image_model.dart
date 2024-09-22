import 'base_model.dart';

class UploadImageModel extends BaseModel {
  final ImageData? data;

  UploadImageModel({
    super.status,
    super.errorCode,
    this.data,
  });

  factory UploadImageModel.fromJson(Map<String, dynamic> json) {
    return UploadImageModel(
      status: json['status'].toString(),
      errorCode: json['error_code'] ?? -1,
      data: json['data'] != null ? ImageData.fromJson(json['data']) : null,
    );
  }
}

class ImageData {
  String? image;

  ImageData({
    this.image,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      image: json['image'],
    );
  }
}
