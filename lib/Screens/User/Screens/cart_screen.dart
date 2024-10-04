import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/cart_provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_links.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Helprs/navigation_service.dart';
import '../../../View_models/families_store_viewmodel.dart';
import '../Widgets/product_counter.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CartProvider, UserManagerProvider>(
      builder: (context, cartManager, userManager, _) {
        if (!userManager.isLoggedIn) {
          return _buildUnregisteredUserView(context);
        }
        if (cartManager.cartViewModel == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        double totalPrice = cartManager.cartViewModel!.items.fold(0,
                (sum, item) => sum! + (item.dishPrice ?? 0) * item.amount!) ??
            0;

        return Scaffold(
          appBar: _buildAppBar(context),
          body: Padding(
            padding: EdgeInsets.all(AppSize.widthSize(25, context)),
            child: RefreshIndicator(
              onRefresh: () async {
                await cartManager.initial();
              },
              child: cartManager.cartViewModel!.items.isEmpty
                  ? Center(
                      child: Text(
                        'لا يوجد عناصر في السلة',
                        style: AppStyles.styleBold(16, context),
                      ),
                    )
                  : ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: cartManager.cartViewModel!.items.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: AppSize.heightSize(14, context)),
                      itemBuilder: (context, index) {
                        final item = cartManager.cartViewModel!.items[index];
                        return _buildDismissibleCartItem(
                            context, item, cartManager);
                      },
                    ),
            ),
          ),
          bottomNavigationBar: cartManager.cartViewModel!.items.isEmpty
              ? null
              : _buildBottomNavigationBar(context, totalPrice, cartManager),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'السلة',
        style: AppStyles.styleBold(14, context),
      ),
    );
  }

  Widget _buildUnregisteredUserView(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle,
              size: AppSize.iconSize(64, context),
              color: AppColors.primaryColor,
            ),
            SizedBox(height: AppSize.heightSize(20, context)),
            Text(
              'يرجى التسجيل لعرض سلة التسوق الخاصة بك',
              style: AppStyles.styleBold(18, context),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSize.heightSize(20, context)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSize.widthSize(10, context)),
              child: ElevatedButton(
                onPressed: () {
                  NavigationService.navigateTo(AppRoutes.accountTypeScreen);
                },
                child: Text(
                  'تسجيل',
                  style: AppStyles.styleBold(12, context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDismissibleCartItem(
      BuildContext context, DishItemViewModel item, CartProvider cartManager) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cartManager.removeFromCart(cartItemId: item.cartItemId!);
      },
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "تأكيد حذف الطبق",
                textAlign: TextAlign.center,
                style: AppStyles.styleBold(16, context),
              ),
              content: Text(
                "هل انت متأكد من أنك تريد حذف الطبق من السلة",
                textAlign: TextAlign.center,
                style: AppStyles.styleMedium(14, context),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    "رجوع",
                    style: AppStyles.styleBold(14, context),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    "تأكيد",
                    style: AppStyles.styleMedium(14, context),
                  ),
                ),
              ],
            );
          },
        );
      },
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: AppSize.widthSize(20, context)),
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: AppSize.iconSize(32, context),
            ),
          ),
        ),
      ),
      child: _buildCartItem(context, item, cartManager),
    );
  }

  Widget _buildCartItem(
      BuildContext context, DishItemViewModel item, CartProvider cartManager) {
    return Container(
      width: AppSize.width(context),
      height: AppSize.heightSize(120, context),
      decoration: BoxDecoration(
        color: Provider.of<AppSettingsProvider>(context).isDark
            ? AppColors.darkContainerBackground
            : Colors.white,
        borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
            child: CachedNetworkImage(
              imageUrl: '${AppLinks.url}${item.dishsImages!.first}',
              width: AppSize.width(context) * 0.33,
              height: AppSize.heightSize(120, context),
              fit: BoxFit.fill,
              progressIndicatorBuilder: (context, url, progress) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Container(
            padding: EdgeInsets.all(AppSize.widthSize(10, context)),
            width: AppSize.width(context) * 0.52,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.dishName ?? '',
                  style: AppStyles.styleBold(14, context),
                ),
                Text(
                  item.dishDescription ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.styleRegular(10, context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item.dishPrice ?? 0} ريال',
                      style: AppStyles.styleBold(14, context)
                          .copyWith(color: AppColors.primaryColor),
                    ),
                    ProductCounter(
                      itemId: item.itemId!,
                      onQuantityChanged: (quantity) {
                        cartManager.updateCartItemQuantity(
                            item.cartItemId!, quantity);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(
      BuildContext context, double totalPrice, CartProvider cartManager) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            // Expanded(
            //   child: ListTile(
            //     title: Text(
            //       'Apple Pay',
            //       style: AppStyles.styleBold(12, context),
            //     ),
            //     leading: Radio<int>(
            //       activeColor: AppColors.primaryColor,
            //       value: 0,
            //       groupValue: cartManager.selectedPaymentMethod,
            //       onChanged: (int? value) {
            //         if (value != null) {
            //           cartManager.setSelectedPaymentMethod(value);
            //         }
            //       },
            //     ),
            //   ),
            // ),
            Expanded(
              child: ListTile(
                title: Text(
                  'الدفع عند الاستلام',
                  style: AppStyles.styleBold(12, context),
                ),
                leading: Radio<int>(
                  activeColor: AppColors.primaryColor,
                  value: 1,
                  groupValue: cartManager.selectedPaymentMethod,
                  onChanged: (int? value) {
                    if (value != null) {
                      cartManager.setSelectedPaymentMethod(value);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSize.heightSize(10, context)),
        Container(
          width: AppSize.width(context),
          height: AppSize.heightSize(80, context),
          padding: EdgeInsets.all(AppSize.widthSize(12, context)),
          color: AppColors.primaryColor.withOpacity(0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'السعر الاجمالي:   $totalPrice ريال',
                    style: AppStyles.styleBold(14, context),
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  await cartManager.checkout();

                  if (context.mounted) {
                    await Provider.of<UserManagerProvider>(context,
                            listen: false)
                        .fetchMyOrders();
                    await NavigationService.navigateTo(
                        AppRoutes.myOrdersScreen);
                  }
                },
                child: Container(
                  width: AppSize.widthSize(100, context),
                  height: AppSize.heightSize(40, context),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius:
                        BorderRadius.circular(AppSize.widthSize(20, context)),
                  ),
                  child: Center(
                    child: Text(
                      'تأكيد الدفع',
                      style: AppStyles.styleBold(12, context).copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
