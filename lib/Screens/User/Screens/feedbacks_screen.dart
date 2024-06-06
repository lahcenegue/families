import 'package:cached_network_image/cached_network_image.dart';
import 'package:families/Utils/Constants/app_size.dart';
import 'package:families/Utils/Constants/app_styles.dart';
import 'package:families/Utils/Helprs/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_links.dart';

class FeedbacksScreen extends StatelessWidget {
  const FeedbacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        final dish = userManager.selectedDish;
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
              padding: EdgeInsets.all(AppSize.widthSize(20, context)),
              children: [
                Container(
                  height: AppSize.heightSize(80, context),
                  padding:
                      EdgeInsets.only(left: AppSize.widthSize(10, context)),
                  decoration: BoxDecoration(
                    color: Provider.of<AppSettingsProvider>(context).isDark
                        ? AppColors.darkContainerBackground
                        : Colors.white,
                    borderRadius:
                        BorderRadius.circular(AppSize.widthSize(20, context)),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            AppSize.widthSize(20, context)),
                        child: CachedNetworkImage(
                          imageUrl:
                              '${AppLinks.url}${dish!.dishsImages!.first}',
                          width: AppSize.widthSize(80, context),
                          height: AppSize.heightSize(80, context),
                          fit: BoxFit.fill,
                          progressIndicatorBuilder: (context, url, progress) =>
                              const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
                                        vertical:
                                            AppSize.heightSize(5, context),
                                        horizontal:
                                            AppSize.widthSize(10, context)),
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
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
