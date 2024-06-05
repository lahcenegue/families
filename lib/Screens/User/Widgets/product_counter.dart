import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';

class ProductCounter extends StatelessWidget {
  final Function(int) onQuantityChanged;

  const ProductCounter({
    super.key,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        return Container(
          //width: AppSize.widthSize(100, context),
          height: AppSize.heightSize(30, context),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: AppSize.iconSize(14, context),
                ),
                onPressed: () {
                  userManager.decrementQuantity();
                  onQuantityChanged(userManager.currentQuantity);
                },
              ),
              Text(
                '${userManager.currentQuantity}',
                style: AppStyles.styleRegular(14, context)
                    .copyWith(color: Colors.white),
              ),
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: AppSize.iconSize(14, context),
                ),
                onPressed: () {
                  userManager.incrementQuantity();
                  onQuantityChanged(userManager.currentQuantity);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
