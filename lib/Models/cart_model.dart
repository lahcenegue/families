import 'base_model.dart';
import 'store_model.dart';

class CartModel extends BaseModel {
  final List<DishModel>? data;

  CartModel({
    super.status,
    super.errorCode,
    this.data,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      status: json['status'].toString(),
      errorCode: json['error_code'] ?? -1,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => DishModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
