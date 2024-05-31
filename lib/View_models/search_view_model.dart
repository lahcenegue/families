import 'package:families/Models/search_model.dart';

class SearchViewModel {
  final SearchModel _searchModel;
  late final List<SearchItemViewModel> items;

  SearchViewModel({required SearchModel searchModel})
      : _searchModel = searchModel {
    items = _searchModel.data
            ?.map((item) => SearchItemViewModel(item: item))
            .toList() ??
        [];
  }
}

class SearchItemViewModel {
  final SearchItem _item;

  SearchItemViewModel({required SearchItem item}) : _item = item;

  int? get itemId => _item.itemId;
  int? get storeId => _item.storeId;
  int? get categoryId => _item.categoryId;
  String? get itemName => _item.itemName;
  double? get price => _item.price;
  String? get description => _item.description;
  int? get preparationTime => _item.preparationTime;
  List<String>? get options => _item.options;
  List<String>? get images => _item.images;
}
