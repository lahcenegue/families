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

  // Expose store properties via getters for easy access
  int get storeId => _store.storeId;
  String get storeName => _store.storeName;
  String get storeDescription => _store.storeDescription;
  String get storeLocation => _store.storeLocation;
  String get storeImage => _store.storeImage;
  double get deliveryCost => _store.deliveryCost;
  String get storeRating => _store.storeRating;

  List<DishItemViewModel> get dishes =>
      _store.dishes.map((dish) => DishItemViewModel(dish: dish)).toList();
}

class DishItemViewModel {
  final Dishes _dishes;

  DishItemViewModel({required Dishes dish}) : _dishes = dish;

  String get disheName => _dishes.disheName;
  double get dishePrice => _dishes.dishePrice;
  String get disheDescription => _dishes.disheDescription;
  List<String> get dishesImages => _dishes.disheImages;
}
