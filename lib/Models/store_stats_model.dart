import 'base_model.dart';

class StoreStatsModel extends BaseModel {
  final StoreStatsData? data;

  StoreStatsModel({
    super.status,
    super.errorCode,
    this.data,
  });

  factory StoreStatsModel.fromJson(Map<String, dynamic> json) {
    return StoreStatsModel(
      status: json['status'],
      errorCode: json['error_code'],
      data: json['data'] != null ? StoreStatsData.fromJson(json['data']) : null,
    );
  }
}

class StoreStatsData {
  final TotalStats total;
  final TotalStats thisMonth;

  StoreStatsData({required this.total, required this.thisMonth});

  factory StoreStatsData.fromJson(Map<String, dynamic> json) {
    return StoreStatsData(
      total: TotalStats.fromJson(json['Total']),
      thisMonth: TotalStats.fromJson(json['This_Month']),
    );
  }
}

class TotalStats {
  final int totalOrders;
  final int totalSales;

  TotalStats({required this.totalOrders, required this.totalSales});

  factory TotalStats.fromJson(Map<String, dynamic> json) {
    return TotalStats(
      totalOrders: json['total_orders'],
      totalSales: json['total_sales'],
    );
  }
}
