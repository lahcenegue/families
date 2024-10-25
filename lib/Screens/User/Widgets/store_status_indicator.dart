import 'package:flutter/material.dart';

import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';

class StoreStatusIndicator extends StatelessWidget {
  final bool isActive;

  const StoreStatusIndicator({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    if (isActive) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.widthSize(12, context),
        vertical: AppSize.heightSize(6, context),
      ),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.9),
        borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time,
            color: Colors.white,
            size: AppSize.iconSize(16, context),
          ),
          SizedBox(width: AppSize.widthSize(4, context)),
          Text(
            'لا يستقبل طلبات',
            style: AppStyles.styleBold(12, context).copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
