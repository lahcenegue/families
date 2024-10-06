import 'base_model.dart';

class ReviewModel extends BaseModel {
  final ReviewData? data;

  ReviewModel({
    required String super.status,
    super.errorCode,
    this.data,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      status: json['status'],
      errorCode: json['error_code'],
      data: json['data'] != null ? ReviewData.fromJson(json['data']) : null,
    );
  }
}

class ReviewData {
  final String itemId;
  final int rating;
  final String message;

  ReviewData({
    required this.itemId,
    required this.rating,
    required this.message,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      itemId: json['ItemId'],
      rating: json['Rating'],
      message: json['Message'],
    );
  }
}
