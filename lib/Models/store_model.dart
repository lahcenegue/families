import 'base_model.dart';
import 'dart:convert' as convert;

class StoreModel extends BaseModel {
  final List<Store>? data;

  StoreModel({
    super.status,
    super.errorCode,
    this.data,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      status: json['status'].toString(),
      errorCode: json['error_code'] ?? -1,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Store.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Store {
  final int storeId;
  final String storeName;
  final String storeDescription;
  final String storeLocation;
  final String storeImage;
  final double deliveryCost;
  final String storeRating;
  final List<Dishes> dishes;

  Store({
    required this.storeId,
    required this.storeName,
    required this.storeDescription,
    required this.storeLocation,
    required this.storeImage,
    required this.deliveryCost,
    required this.storeRating,
    required this.dishes,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      storeId: json['StoreId'],
      storeName: json['StoreName'],
      storeDescription: json['Description'],
      storeLocation: json['Location'],
      storeImage: json['Image'],
      deliveryCost: json['DeliveryCost'].toDouble(),
      storeRating: json['StoreRating'].toString(),
      dishes: (json['Items'] as List<dynamic>)
          .map((item) => Dishes.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Dishes {
  final String disheName;
  final double dishePrice;
  final String disheDescription;
  final List<String> disheImages;

  Dishes({
    required this.disheName,
    required this.dishePrice,
    required this.disheImages,
    required this.disheDescription,
  });

  factory Dishes.fromJson(Map<String, dynamic> json) {
    List<String> images = [];

    images = (convert.jsonDecode(json['Images']) as List<dynamic>)
        .map((imageJson) => imageJson.toString())
        .toList();

    return Dishes(
      disheName: json['ItemName'],
      dishePrice: json['Price'].toDouble(),
      disheDescription: json['Description'],
      disheImages: images,
    );
  }
}
