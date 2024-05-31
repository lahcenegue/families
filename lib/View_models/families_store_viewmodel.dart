import 'package:families/Models/store_model.dart';

class FamiliesStoreViewModel {
  final StoreModel _storeModel;
  late final List<StoreItemViewModel> stores;

  FamiliesStoreViewModel({required StoreModel storeModel})
      : _storeModel = storeModel {
    stores = _storeModel.data
            ?.map((store) => StoreItemViewModel(store: store))
            .toList() ??
        [];
  }
}

class StoreItemViewModel {
  final Store _store;

  StoreItemViewModel({required Store store}) : _store = store;

  int? get storeId => _store.storeId;
  String? get storeName => _store.storeName;
  String? get storeDescription => _store.storeDescription;
  String? get storeLocation => _store.storeLocation;
  String? get storeImage => _store.storeImage;
  double? get deliveryCost => _store.deliveryCost;
  String? get storeRating => _store.storeRating;
  bool? get favorite => _store.isFavorite;

  List<DishItemViewModel> get dishs =>
      _store.dishs!.map((dish) => DishItemViewModel(dish: dish)).toList();
}

class DishItemViewModel {
  final Dishs _dishs;

  DishItemViewModel({required Dishs dish}) : _dishs = dish;

  String? get disheName => _dishs.dishName;
  double? get dishePrice => _dishs.dishPrice;
  String? get disheDescription => _dishs.dishDescription;
  List<String>? get dishesImages => _dishs.dishImages;
}
