import '../Models/store_stats_model.dart';

class StoreStatsViewModel {
  final StoreStatsModel _model;

  StoreStatsViewModel({required StoreStatsModel model}) : _model = model;

  TotalStatsViewModel get total =>
      TotalStatsViewModel(stats: _model.data!.total);
  TotalStatsViewModel get thisMonth =>
      TotalStatsViewModel(stats: _model.data!.thisMonth);
}

class TotalStatsViewModel {
  final TotalStats _stats;

  TotalStatsViewModel({required TotalStats stats}) : _stats = stats;

  int get totalOrders => _stats.totalOrders;
  int get totalSales => _stats.totalSales;
}
