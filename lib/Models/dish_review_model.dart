import 'base_model.dart';

class DishReviewModel extends BaseModel {
  final List<DishReview>? data;

  DishReviewModel({
    super.status,
    super.errorCode,
    this.data,
  });

  factory DishReviewModel.fromJson(Map<String, dynamic> json) {
    return DishReviewModel(
      status: json['status'].toString(),
      errorCode: json['error_code'] ?? -1,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => DishReview.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DishReview {
  int? rating;
  String? message;
  String? userName;

  DishReview({
    this.rating,
    this.message,
    this.userName,
  });

  factory DishReview.fromJson(Map<String, dynamic> json) {
    return DishReview(
      rating: json['Rating'],
      message: json['Message'],
      userName: json['UserName'],
    );
  }
}
