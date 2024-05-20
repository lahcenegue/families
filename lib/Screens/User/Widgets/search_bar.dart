import 'package:flutter/material.dart';

import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_size.dart';

Widget searchBar(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      SizedBox(
        width: AppSize.widthSize(250, context),
        child: TextFormField(),
      ),
      Container(
        width: AppSize.widthSize(50, context),
        height: AppSize.heightSize(40, context),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.tune_rounded,
          size: AppSize.widthSize(30, context),
        ),
      ),
    ],
  );
}
