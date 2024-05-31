import 'package:cached_network_image/cached_network_image.dart';
import 'package:families/Providers/app_settings_provider.dart';
import 'package:families/Utils/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_links.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';

class DisheView extends StatelessWidget {
  const DisheView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        final dish = userManager.selectedDish;
        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: EdgeInsets.all(AppSize.widthSize(25, context)),
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppSize.widthSize(20, context)),
                child: CachedNetworkImage(
                  imageUrl: '${AppLinks.url}${dish!.dishesImages!.first}',
                  width: AppSize.width(context),
                  height: AppSize.heightSize(225, context),
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, progress) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(height: AppSize.heightSize(25, context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dish.disheName!,
                        style: AppStyles.styleBold(20, context),
                      ),
                      Text(
                        'family name',
                        style: AppStyles.styleRegular(14, context),
                      ),
                    ],
                  ),
                  Text(
                    '${dish.dishePrice} Rial',
                    style: AppStyles.styleExtraBold(16, context),
                  )
                ],
              ),
              SizedBox(height: AppSize.heightSize(20, context)),
              Container(
                width: AppSize.width(context),
                height: AppSize.heightSize(66, context),
                padding: EdgeInsets.all(AppSize.widthSize(12, context)),
                decoration: BoxDecoration(
                  color: Provider.of<AppSettingsProvider>(context).isDark
                      ? AppColors.darkContainerBackground
                      : const Color(0xffF0F5FF),
                  borderRadius:
                      BorderRadius.circular(AppSize.widthSize(20, context)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'التقييمات',
                          style: AppStyles.styleBold(14, context),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: AppSize.iconSize(24, context),
                    )
                  ],
                ),
              ),
              SizedBox(height: AppSize.heightSize(20, context)),
              Text(
                'وصف الطبق',
                style: AppStyles.styleBold(16, context),
              ),
              Text(
                dish.disheDescription!,
                style: AppStyles.styleRegular(12, context),
              ),
              SizedBox(height: AppSize.heightSize(20, context)),
              SizedBox(
                width: AppSize.widthSize(340, context),
                child: ElevatedButton(
                    onPressed: () {}, child: Text('اضف الى السلة')),
              ),
            ],
          ),
        );
      },
    );
  }
}
