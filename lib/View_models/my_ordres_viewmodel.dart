import 'package:intl/intl.dart';
import '../Models/my_ordres_model.dart';
import '../Utils/Constants/app_links.dart';

class MyOrdersViewModel {
  final MyOrdersModel _responseModel;
  late final List<CustomerOrdersViewModel> customerOrders;

  MyOrdersViewModel({required MyOrdersModel responseModel})
      : _responseModel = responseModel {
    customerOrders = _responseModel.data?.entries.map((entry) {
          List<ItemViewModel> items = entry.value
              .map((item) => ItemViewModel(responseItem: item))
              .toList();
          return CustomerOrdersViewModel(
              customerName: entry.key, orders: items);
        }).toList() ??
        [];

    _sortCustomersAndOrders();
  }

  void _sortCustomersAndOrders() {
    // Sort customers based on unsent orders and then by most recent order
    customerOrders.sort((a, b) {
      bool aHasUnsentOrders = a.orders.any((order) => order.status != 2);
      bool bHasUnsentOrders = b.orders.any((order) => order.status != 2);
      if (aHasUnsentOrders != bHasUnsentOrders) {
        return aHasUnsentOrders ? -1 : 1;
      }
      return b.mostRecentOrderDate.compareTo(a.mostRecentOrderDate);
    });

    // Sort orders for each customer by date (newest first)
    for (var customerOrder in customerOrders) {
      customerOrder.orders.sort((a, b) => b.date!.compareTo(a.date!));
    }
  }

  bool get isEmpty => customerOrders.isEmpty;
}

class CustomerOrdersViewModel {
  final String customerName;
  final List<ItemViewModel> orders;

  CustomerOrdersViewModel({required this.customerName, required this.orders});

  DateTime get mostRecentOrderDate {
    return orders.isNotEmpty
        ? DateTime.fromMillisecondsSinceEpoch(orders.first.date! * 1000)
        : DateTime(1970);
  }
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
  int? get date => _responseItem.date;

  String get formattedDate {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(date! * 1000);
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



// import 'package:intl/intl.dart';

// import '../Models/my_ordres_model.dart';
// import '../Utils/Constants/app_links.dart';

// class MyOrdersViewModel {
//   final MyOrdersModel _responseModel;
//   late final Map<String, List<ItemViewModel>> ordres;

//   MyOrdersViewModel({required MyOrdersModel responseModel})
//       : _responseModel = responseModel {
//     ordres = _responseModel.data?.map((key, value) {
//           return MapEntry(
//             key,
//             value.map((item) => ItemViewModel(responseItem: item)).toList(),
//           );
//         }) ??
//         {};
//   }

//   List<String> get storeName => ordres.keys.toList();
//   bool get isEmpty => ordres.isEmpty;
// }

// class ItemViewModel {
//   final Item _responseItem;

//   ItemViewModel({required Item responseItem}) : _responseItem = responseItem;

//   int? get cartItemId => _responseItem.cartItemId;
//   int? get userId => _responseItem.userId;
//   int? get storeId => _responseItem.storeId;
//   int? get itemId => _responseItem.itemId;
//   int? get amount => _responseItem.amount;
//   int? get status => _responseItem.status;
//   String? get itemName => _responseItem.itemName;
//   List<String>? get images => _responseItem.images;
//   String? get userName => _responseItem.userName;
//   String? get method => _responseItem.method;
//   String? get orderStatus => _responseItem.orderStatus;
//   String? get storeName => _responseItem.storeName;
//   int? get date => _responseItem.date;

//   String get formattedDate {
//     final dateTime = DateTime.fromMillisecondsSinceEpoch(date! * 1000);
//     return DateFormat('M/d/y').format(dateTime);
//   }

//   String? get firstImage =>
//       images?.isNotEmpty == true ? '${AppLinks.url}${images!.first}' : null;

//   String get statusText {
//     switch (status) {
//       case 1:
//         return 'قيد التحضير';
//       case 2:
//         return 'تم التوصيل';
//       case 3:
//         return 'ملغى';
//       default:
//         return 'Unknown';
//     }
//   }
// }
