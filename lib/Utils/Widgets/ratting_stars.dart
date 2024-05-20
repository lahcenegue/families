import 'package:families/Utils/Constants/app_colors.dart';
import 'package:families/Utils/Constants/app_size.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;

  const StarRating({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = List.generate(5, (index) => buildStar(context, index));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index < rating) {
      if (index + 1 > rating && rating - index >= 0.5) {
        icon = Icon(Icons.star_half,
            color: AppColors.starColor, size: AppSize.iconSize(30, context));
      } else {
        // Full star
        icon = Icon(Icons.star,
            color: AppColors.starColor, size: AppSize.iconSize(30, context));
      }
    } else {
      // Unfilled star
      icon = Icon(Icons.star_border,
          color: AppColors.starColor, size: AppSize.iconSize(30, context));
    }
    return icon;
  }
}
