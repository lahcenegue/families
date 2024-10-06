import '../Models/add_review_model.dart';

class ReviewViewModel {
  final ReviewModel _model;

  ReviewViewModel({required ReviewModel model}) : _model = model;

  String get itemId => _model.data?.itemId ?? '';
  int get rating => _model.data?.rating ?? 0;
  String get message => _model.data?.message ?? '';
}
