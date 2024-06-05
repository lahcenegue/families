import 'package:cached_network_image/cached_network_image.dart';
import 'package:families/Utils/Helprs/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_links.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../View_models/families_store_viewmodel.dart';
import '../Widgets/product_counter.dart';

class DisheView extends StatelessWidget {
  const DisheView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        final dish = userManager.selectedDish;
        if (dish == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: EdgeInsets.all(AppSize.widthSize(25, context)),
            children: [
              _buildDishImage(context, dish),
              SizedBox(height: AppSize.heightSize(25, context)),
              _buildDishHeader(context, dish),
              SizedBox(height: AppSize.heightSize(20, context)),
              _buildRatingsContainer(context, dish),
              SizedBox(height: AppSize.heightSize(20, context)),
              _buildDishDescription(context, dish),
            ],
          ),
          bottomNavigationBar: _buildAddToCartButton(context),
        );
      },
    );
  }

  Widget _buildDishImage(BuildContext context, DishItemViewModel dish) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
      child: CachedNetworkImage(
        imageUrl: '${AppLinks.url}${dish.dishsImages!.first}',
        width: AppSize.width(context),
        height: AppSize.heightSize(225, context),
        fit: BoxFit.fill,
        progressIndicatorBuilder: (context, url, progress) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildDishHeader(BuildContext context, DishItemViewModel dish) {
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
          'family name',
          style: AppStyles.styleRegular(14, context),
        ),
        SizedBox(height: AppSize.heightSize(8, context)),
        Row(
          children: [
            const Spacer(),
            ProductCounter(
              onQuantityChanged: (quantity) {},
            ),
          ],
        ),
        SizedBox(height: AppSize.heightSize(8, context)),
        Row(
          children: [
            Icon(
              Icons.access_time,
              color: AppColors.redColor,
              size: AppSize.iconSize(28, context),
            ),
            SizedBox(width: AppSize.widthSize(5, context)),
            Text(
              'وقت اعداد الطبق',
              style: AppStyles.styleBold(16, context),
            )
          ],
        ),
        Text(
          '2 ساعة',
          style: AppStyles.styleRegular(15, context),
        ),
      ],
    );
  }

  Widget _buildRatingsContainer(BuildContext context, DishItemViewModel dish) {
    final appSettings = Provider.of<AppSettingsProvider>(context);
    return Container(
      width: AppSize.width(context),
      height: AppSize.heightSize(75, context),
      padding: EdgeInsets.all(AppSize.widthSize(12, context)),
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
                    dish.dishRating.toString(),
                    style: AppStyles.styleBold(16, context),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              NavigationService.navigateTo(AppRoutes.feedbackScreen);
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

  Widget _buildAddToCartButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSize.widthSize(25, context)),
      child: SizedBox(
        width: AppSize.widthSize(340, context),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('اضف الى السلة'),
        ),
      ),
    );
  }
}
