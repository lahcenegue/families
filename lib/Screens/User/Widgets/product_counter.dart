import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/cart_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';

class ProductCounter extends StatelessWidget {
  final int itemId;
  final Function(int) onQuantityChanged;

  const ProductCounter({
    super.key,
    required this.onQuantityChanged,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartManager, _) {
        int currentQuantity = cartManager.getQuantity(itemId);

        return Container(
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
                  cartManager.decrementQuantity(itemId);
                  onQuantityChanged(cartManager.getQuantity(itemId));
                },
              ),
              Text(
                '$currentQuantity',
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
                  cartManager.incrementQuantity(itemId);
                  onQuantityChanged(cartManager.getQuantity(itemId));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
