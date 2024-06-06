import 'package:cached_network_image/cached_network_image.dart';
import 'package:families/Utils/Constants/app_size.dart';
import 'package:families/Utils/Constants/app_styles.dart';
import 'package:families/Utils/Helprs/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_links.dart';
import '../../../View_models/families_store_viewmodel.dart';

class FeedbacksScreen extends StatelessWidget {
  const FeedbacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        final dish = userManager.selectedDish;
        final reviews = userManager.filteredReviews;

        if (userManager.dishReviewViewModel == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'التقييمات',
                style: AppStyles.styleBold(14, context),
              ),
            ),
            body: ListView(
              //padding: EdgeInsets.all(AppSize.widthSize(20, context)),
              children: [
                _buildDishHeader(context, dish),
                SizedBox(height: AppSize.heightSize(20, context)),
                _buildRatingFilterBar(context, userManager),
                ...reviews.map(
                  (review) => Container(
                    // height: AppSize.heightSize(130, context),
                    margin: EdgeInsets.all(AppSize.widthSize(20, context)),
                    padding: EdgeInsets.all(AppSize.widthSize(12, context)),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppSize.widthSize(24, context)),
                      color: Provider.of<AppSettingsProvider>(context).isDark
                          ? AppColors.darkContainerBackground
                          : const Color(0xffF0F5FF),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                            child: Image.asset(
                          AppImages.profilImage,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )),
                        SizedBox(width: AppSize.widthSize(15, context)),
                        SizedBox(
                          width: AppSize.widthSize(240, context),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    review.userName!,
                                    style: AppStyles.styleBold(14, context),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(
                                        review.rating ?? 0,
                                        (index) => Icon(Icons.star,
                                            color: AppColors.starColor,
                                            size: 16)),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppSize.heightSize(8, context)),
                              Text(
                                review.message!,
                                textAlign: TextAlign.justify,
                                style: AppStyles.styleRegular(14, context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //    Text(review.message),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildDishHeader(BuildContext context, DishItemViewModel? dish) {
    return Container(
      height: AppSize.heightSize(80, context),
      padding: EdgeInsets.only(left: AppSize.widthSize(10, context)),
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
              imageUrl: '${AppLinks.url}${dish!.dishsImages!.first}',
              width: AppSize.widthSize(80, context),
              height: AppSize.heightSize(80, context),
              fit: BoxFit.fill,
              progressIndicatorBuilder: (context, url, progress) =>
                  const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(width: AppSize.widthSize(12, context)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dish.dishName!,
                  style: AppStyles.styleMedium(12, context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${dish.dishPrice} ريال',
                      style: AppStyles.styleBold(12, context)
                          .copyWith(color: AppColors.redColor),
                    ),
                    InkWell(
                      onTap: () {
                        NavigationService.goBack();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSize.heightSize(5, context),
                            horizontal: AppSize.widthSize(10, context)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primaryColor,
                        ),
                        child: Text(
                          'اطلب هنا',
                          style: AppStyles.styleRegular(12, context)
                              .copyWith(color: Colors.white),
                        ),
                      ),
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

  Widget _buildRatingFilterBar(
      BuildContext context, UserManagerProvider userManager) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildRatingButton(context, userManager, 0, 'الجميع'),
          _buildRatingButton(context, userManager, 1, '1'),
          _buildRatingButton(context, userManager, 2, '2'),
          _buildRatingButton(context, userManager, 3, '3'),
          _buildRatingButton(context, userManager, 4, '4'),
          _buildRatingButton(context, userManager, 5, '5'),
        ],
      ),
    );
  }

  Widget _buildRatingButton(BuildContext context,
      UserManagerProvider userManager, int rating, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.widthSize(5, context)),
      child: InkWell(
        onTap: () {
          userManager.setSelectedRating(rating);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.widthSize(16, context),
              vertical: AppSize.widthSize(8, context)),
          decoration: BoxDecoration(
            color: userManager.selectedRating == rating
                ? AppColors.primaryColor
                : AppColors.reviewBoxcolor,
            borderRadius:
                BorderRadius.circular(AppSize.heightSize(50, context)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: AppColors.starColor,
                size: AppSize.iconSize(24, context),
              ),
              SizedBox(width: AppSize.widthSize(7, context)),
              Text(
                label,
                style: AppStyles.styleBold(10, context).copyWith(
                  color: userManager.selectedRating == rating
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
