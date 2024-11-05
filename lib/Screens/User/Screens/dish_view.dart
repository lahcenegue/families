import 'package:cached_network_image/cached_network_image.dart';
import 'package:families/Providers/cart_provider.dart';
import 'package:families/Utils/Helprs/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_links.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Widgets/app_messages.dart';
import '../../../Utils/Widgets/custom_loading_indicator.dart';
import '../../../View_models/families_store_viewmodel.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'feedbacks_screen.dart';

class DisheView extends StatelessWidget {
  final DishItemViewModel dish;

  const DisheView({
    required this.dish,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserManagerProvider, CartProvider>(
      builder: (context, userManager, cartManager, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              dish.dishName ?? '',
              style: AppStyles.styleBold(18, context),
            ),
          ),
          body: Stack(
            children: [
              _buildContent(context, userManager, dish),
              CustomLoadingIndicator(
                isVisible: cartManager.addTocartProcess,
              ),
              if (!dish.isStoreActive)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.03),
                  ),
                ),
            ],
          ),
          bottomNavigationBar: !dish.isStoreActive
              ? _buildInactiveStoreBar(context)
              : _buildAddToCartButton(context, userManager, cartManager, dish),
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    UserManagerProvider userManager,
    DishItemViewModel dish,
  ) {
    return ListView(
      padding: EdgeInsets.all(AppSize.widthSize(25, context)),
      children: [
        _buildDishImage(context, dish),
        if (!dish.isStoreActive) _buildInactiveStoreIndicator(context),
        SizedBox(height: AppSize.heightSize(25, context)),
        _buildDishHeader(context, dish, userManager),
        SizedBox(height: AppSize.heightSize(20, context)),
        _buildRatingsContainer(context, dish, userManager),
        SizedBox(height: AppSize.heightSize(20, context)),
        _buildDishDescription(context, dish),
        // Add extra padding at bottom if store is inactive
        if (!dish.isStoreActive)
          SizedBox(height: AppSize.heightSize(60, context)),
      ],
    );
  }

  Widget _buildInactiveStoreIndicator(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSize.heightSize(16, context),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.widthSize(16, context),
          vertical: AppSize.heightSize(8, context),
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
            SizedBox(width: AppSize.widthSize(8, context)),
            Text(
              'لا يستقبل طلبات',
              style: AppStyles.styleBold(12, context).copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInactiveStoreBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.widthSize(25, context)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSize.heightSize(12, context),
          horizontal: AppSize.widthSize(16, context),
        ),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppSize.widthSize(12, context)),
          border: Border.all(color: Colors.red.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.access_time,
              color: Colors.red,
              size: AppSize.iconSize(24, context),
            ),
            SizedBox(width: AppSize.widthSize(8, context)),
            Text(
              'المتجر لا يستقبل طلبات حالياً',
              style: AppStyles.styleBold(14, context).copyWith(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDishImage(
    BuildContext context,
    DishItemViewModel dish,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: '${AppLinks.url}${dish.dishsImages!.first}',
            width: AppSize.width(context),
            height: AppSize.heightSize(225, context),
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, progress) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          if (!dish.isStoreActive)
            Container(
              width: AppSize.width(context),
              height: AppSize.heightSize(225, context),
              color: Colors.black.withOpacity(0.3),
            ),
        ],
      ),
    );
  }

  Widget _buildDishHeader(BuildContext context, DishItemViewModel dish,
      UserManagerProvider userManager) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dish.dishName!,
              style: AppStyles.styleBold(20, context),
            ),
            Text(
              '${dish.dishPrice} ريال',
              style: AppStyles.styleExtraBold(16, context),
            ),
          ],
        ),
        Text(
          '${dish.storeName}',
          style: AppStyles.styleRegular(14, context),
        ),
        SizedBox(height: AppSize.heightSize(8, context)),
        SizedBox(height: AppSize.heightSize(8, context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.access_time,
              color: AppColors.redColor,
              size: AppSize.iconSize(24, context),
            ),
            SizedBox(width: AppSize.widthSize(12, context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'وقت اعداد الطبق',
                  style: AppStyles.styleBold(16, context),
                ),
                Text(
                  '${dish.preparationTime} دقيقة',
                  style: AppStyles.styleRegular(15, context),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingsContainer(
    BuildContext context,
    DishItemViewModel dish,
    UserManagerProvider userManager,
  ) {
    final appSettings = Provider.of<AppSettingsProvider>(context);
    return Container(
      width: AppSize.width(context),
      height: AppSize.heightSize(80, context),
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.widthSize(20, context),
        vertical: AppSize.widthSize(8, context),
      ),
      decoration: BoxDecoration(
        color: appSettings.isDark
            ? AppColors.darkContainerBackground
            : const Color(0xffF0F5FF),
        borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'التقييمات',
                style: AppStyles.styleBold(14, context),
              ),
              SizedBox(height: AppSize.heightSize(8, context)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.starColor,
                    size: AppSize.iconSize(24, context),
                  ),
                  SizedBox(width: AppSize.widthSize(5, context)),
                  Text(
                    '${dish.dishRating}',
                    style: AppStyles.styleBold(16, context),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () async {
              userManager.getDishReviews(itemID: dish.itemId!);
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FeedbacksScreen(dish: dish)));
            },
            icon: Icon(
              Icons.arrow_forward,
              size: AppSize.iconSize(24, context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDishDescription(BuildContext context, DishItemViewModel dish) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'وصف الطبق',
          style: AppStyles.styleBold(16, context),
        ),
        Text(
          dish.dishDescription!,
          style: AppStyles.styleRegular(12, context),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(
    BuildContext context,
    UserManagerProvider userManager,
    CartProvider cartManager,
    DishItemViewModel dish,
  ) {
    return Padding(
      padding: EdgeInsets.all(AppSize.widthSize(25, context)),
      child: SizedBox(
        width: AppSize.widthSize(340, context),
        child: ElevatedButton(
          onPressed: () async {
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            final appLocalizations = AppLocalizations.of(context);

            if (userManager.isLoggedIn) {
              int? result = await cartManager.addToCart(
                itemId: dish.itemId!,
                amount: 1,
              );
              String message = appErrorMessages(result, appLocalizations!);
              scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text(
                          'تسجيل الدخول مطلوب',
                          textAlign: TextAlign.center,
                          style: AppStyles.styleBold(16, context),
                        ),
                        content: Text(
                          'يرجى تسجيل الدخول لتتمكن من إضافة المنتج إلى السلة وإتمام عملية الشراء',
                          textAlign: TextAlign.center,
                          style: AppStyles.styleMedium(14, context),
                        ),
                        actions: [
                          TextButton(
                            child: Text(
                              'رجوع',
                              style: AppStyles.styleMedium(14, context),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('تسجيل',
                                style: AppStyles.styleBold(14, context)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              NavigationService.navigateTo(
                                  AppRoutes.accountTypeScreen);
                            },
                          ),
                        ]);
                  });
            }
          },
          child: Text(
            'اضف الى السلة',
            style: AppStyles.styleBold(12, context),
          ),
        ),
      ),
    );
  }
}
