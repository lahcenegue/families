import '../Models/my_dishs_model.dart';

class MyDishsViewmodel {
  final MyDishsModel _myDishsModel;
  late final List<MyDishViewModel> items;

  MyDishsViewmodel({required MyDishsModel myDishsModel})
      : _myDishsModel = myDishsModel {
    items = _myDishsModel.data
            ?.map((item) => MyDishViewModel(item: item))
            .toList() ??
        [];
  }
}

class MyDishViewModel {
  final MyDish _item;

  MyDishViewModel({required MyDish item}) : _item = item;

  int? get itemId => _item.itemId;
  int? get storeId => _item.storeId;
  int? get categoryId => _item.categoryId;
  String? get itemName => _item.itemName;
  double? get price => _item.price;
  String? get description => _item.description;
  int? get preparationTime => _item.preparationTime;
}
