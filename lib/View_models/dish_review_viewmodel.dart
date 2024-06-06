import 'package:families/Models/dish_review_model.dart';

class DishReviewViewModel {
  final DishReviewModel _dishReviewModel;
  late final List<DishReviewItemViewModel> items;

  DishReviewViewModel({required DishReviewModel dishReviewModel})
      : _dishReviewModel = dishReviewModel {
    items = _dishReviewModel.data
            ?.map((item) => DishReviewItemViewModel(review: item))
            .toList() ??
        [];
  }
}

class DishReviewItemViewModel {
  final DishReview _review;

  DishReviewItemViewModel({required DishReview review}) : _review = review;

  int? get rating => _review.rating;
  String? get message => _review.message;
  String? get userName => _review.userName;
}
