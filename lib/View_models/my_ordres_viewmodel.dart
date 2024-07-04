import '../Models/my_ordres_model.dart';
import '../Utils/Constants/app_links.dart';

class MyOrdersViewModel {
  final MyOrdersModel _responseModel;
  late final Map<String, List<ItemViewModel>> users;

  MyOrdersViewModel({required MyOrdersModel responseModel})
      : _responseModel = responseModel {
    users = _responseModel.data?.map((key, value) {
          return MapEntry(
            key,
            value.map((item) => ItemViewModel(responseItem: item)).toList(),
          );
        }) ??
        {};
  }

  List<String> get userNames => users.keys.toList();
}

class ItemViewModel {
  final Item _responseItem;

  ItemViewModel({required Item responseItem}) : _responseItem = responseItem;

  int? get userId => _responseItem.userId;
  int? get itemId => _responseItem.itemId;
  int? get amount => _responseItem.amount;
  String? get itemName => _responseItem.itemName;
  List<String>? get images => _responseItem.images;
  String? get userName => _responseItem.userName;

  String? get firstImage =>
      images?.isNotEmpty == true ? '${AppLinks.url}${images!.first}' : null;
}
