import 'package:intl/intl.dart';

import '../Models/my_ordres_model.dart';
import '../Utils/Constants/app_links.dart';

class MyOrdersViewModel {
  final MyOrdersModel _responseModel;
  late final Map<String, List<ItemViewModel>> ordres;

  MyOrdersViewModel({required MyOrdersModel responseModel})
      : _responseModel = responseModel {
    ordres = _responseModel.data?.map((key, value) {
          return MapEntry(
            key,
            value.map((item) => ItemViewModel(responseItem: item)).toList(),
          );
        }) ??
        {};
  }

  List<String> get storeName => ordres.keys.toList();
}

class ItemViewModel {
  final Item _responseItem;

  ItemViewModel({required Item responseItem}) : _responseItem = responseItem;

  int? get cartItemId => _responseItem.cartItemId;
  int? get userId => _responseItem.userId;
  int? get storeId => _responseItem.storeId;
  int? get itemId => _responseItem.itemId;
  int? get amount => _responseItem.amount;
  int? get status => _responseItem.status;
  String? get itemName => _responseItem.itemName;
  List<String>? get images => _responseItem.images;
  String? get userName => _responseItem.userName;
  String? get method => _responseItem.method;

  String? get orderStatus => _responseItem.orderStatus;
  String? get storeName => _responseItem.storeName;

  String? get date {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(_responseItem.date! * 1000);
    return DateFormat('M/d/y').format(dateTime);
  }

  String? get firstImage =>
      images?.isNotEmpty == true ? '${AppLinks.url}${images!.first}' : null;

  String get statusText {
    switch (status) {
      case 1:
        return 'قيد التحضير';
      case 2:
        return 'تم التوصيل';
      case 3:
        return 'ملغى';
      default:
        return 'Unknown';
    }
  }
}
