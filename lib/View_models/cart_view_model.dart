import 'package:families/Models/cart_model.dart';

import 'families_store_viewmodel.dart';

class CartViewModel {
  final CartModel _cartModel;
  late final List<DishItemViewModel> items;

  CartViewModel({required CartModel cartModel}) : _cartModel = cartModel {
    items = _cartModel.data
            ?.map((item) => DishItemViewModel(dish: item))
            .toList() ??
        [];
  }
}
