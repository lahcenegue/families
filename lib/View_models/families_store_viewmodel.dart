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
  bool? get favorite => _store.isFavorite ?? false;
  bool get isActive => _store.active == 1;

  List<DishItemViewModel> get dishs => _store.dishs!
      .map((dish) => DishItemViewModel(
            dish: dish,
            storeActive: _store
                .active, // Pass store's active status to DishItemViewModel
          ))
      .toList();
}

class DishItemViewModel {
  final DishModel _dish;
  final int? storeActive;
  int currentQuantity;

  DishItemViewModel({
    required DishModel dish,
    this.storeActive, // Accept store active status
    this.currentQuantity = 1,
  }) : _dish = dish;

  int? get cartItemId => _dish.cartItemId;
  int? get itemId => _dish.itemId;
  int? get storeId => _dish.storeId;
  int? get amount => _dish.amount;
  String? get dishName => _dish.dishName;
  String? get storeName => _dish.storeName;
  double? get dishPrice => _dish.dishPrice;
  String? get dishDescription => _dish.dishDescription;
  List<String>? get dishsImages => _dish.dishImages;
  double? get dishRating => _dish.dishRating;
  int? get preparationTime => _dish.preparationTime;
  bool get isStoreActive => storeActive == 1; // Use passed store active status

  void updateAmount(int newAmount) {
    _dish.amount = newAmount;
  }
}
