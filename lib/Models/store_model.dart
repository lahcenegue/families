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
  int? storeId;
  String? storeName;
  String? storeDescription;
  String? storeLocation;
  String? storeImage;
  double? deliveryCost;
  String? storeRating;
  bool? isFavorite;
  List<Dishs>? dishs;

  Store({
    this.storeId,
    this.storeName,
    this.storeDescription,
    this.storeLocation,
    this.storeImage,
    this.deliveryCost,
    this.storeRating,
    this.isFavorite,
    this.dishs,
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
      isFavorite: json['isFavourite'],
      dishs: (json['Items'] as List<dynamic>)
          .map((item) => Dishs.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Dishs {
  String? dishName;
  double? dishPrice;
  String? dishDescription;
  List<String>? dishImages;

  Dishs({
    this.dishName,
    this.dishPrice,
    this.dishImages,
    this.dishDescription,
  });

  factory Dishs.fromJson(Map<String, dynamic> json) {
    List<String> images = [];

    images = (convert.jsonDecode(json['Images']) as List<dynamic>)
        .map((imageJson) => imageJson.toString())
        .toList();

    return Dishs(
      dishName: json['ItemName'],
      dishPrice: json['Price'].toDouble(),
      dishDescription: json['Description'],
      dishImages: images,
    );
  }
}
