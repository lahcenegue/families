import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_links.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Widgets/ratting_stars.dart';
import '../Widgets/dishe_box.dart';

class StoreView extends StatelessWidget {
  const StoreView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        final store = userManager.selectedStore;

        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: EdgeInsets.all(AppSize.widthSize(25, context)),
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppSize.widthSize(20, context)),
                child: CachedNetworkImage(
                  imageUrl: '${AppLinks.url}${store!.storeImage}',
                  width: AppSize.width(context),
                  height: AppSize.heightSize(225, context),
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, progress) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(height: AppSize.heightSize(25, context)),
              Text(
                store.storeName,
                style: AppStyles.styleBold(20, context),
              ),
              SizedBox(height: AppSize.heightSize(8, context)),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.starColor,
                    size: AppSize.iconSize(24, context),
                  ),
                  SizedBox(width: AppSize.widthSize(5, context)),
                  Text(
                    store.storeRating,
                    style: AppStyles.styleBold(16, context),
                  )
                ],
              ),
              SizedBox(height: AppSize.heightSize(8, context)),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.primaryColor,
                    size: AppSize.iconSize(30, context),
                  ),
                  SizedBox(width: AppSize.widthSize(5, context)),
                  Text(
                    store.storeLocation,
                    style: AppStyles.styleRegular(14, context),
                  ),
                ],
              ),
              SizedBox(height: AppSize.heightSize(8, context)),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'سعر التوصيل',
                      style: AppStyles.styleBold(16, context),
                    ),
                    TextSpan(
                      text: '${store.deliveryCost} rial',
                      style: AppStyles.styleBold(16, context)
                          .copyWith(color: Colors.red),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSize.heightSize(8, context)),
              Text(
                'نبذة',
                style: AppStyles.styleBold(16, context),
              ),
              Text(
                store.storeDescription,
                style: AppStyles.styleRegular(12, context),
              ),
              SizedBox(height: AppSize.heightSize(8, context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('الاطباق', style: AppStyles.styleBold(16, context)),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'عرض الكل',
                      style: AppStyles.styleBold(10, context).copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize.heightSize(8, context)),
              SizedBox(
                width: AppSize.width(context),
                height: AppSize.heightSize(180, context),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: store.dishes.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: AppSize.widthSize(10, context)),
                  itemBuilder: (context, index) => DisheBox(
                    dish: store.dishes[index],
                  ),
                ),
              ),
              SizedBox(height: AppSize.heightSize(40, context)),
              Container(
                padding: EdgeInsets.all(AppSize.widthSize(25, context)),
                decoration: BoxDecoration(
                  color: Provider.of<AppSettingsProvider>(context).isDark
                      ? AppColors.darkContainerBackground
                      : Colors.white,
                  borderRadius:
                      BorderRadius.circular(AppSize.widthSize(20, context)),
                  border: Border.all(
                    width: 1.5,
                    color: const Color(0xFFE0E0E0),
                  ),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSize.widthSize(20, context)),
                      child: CachedNetworkImage(
                        imageUrl: '${AppLinks.url}${store.storeImage}',
                        width: AppSize.widthSize(60, context),
                        height: AppSize.widthSize(60, context),
                        fit: BoxFit.fill,
                        progressIndicatorBuilder: (context, url, progress) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Text(
                      store.storeName,
                      style: AppStyles.styleBold(20, context),
                    ),
                    StarRating(rating: double.parse(store.storeRating)),
                    SizedBox(height: AppSize.heightSize(30, context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone_outlined,
                                size: AppSize.widthSize(22, context),
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(width: AppSize.widthSize(8, context)),
                              Text(
                                'اتصال',
                                style: AppStyles.styleBold(12, context),
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                size: AppSize.widthSize(22, context),
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(width: AppSize.widthSize(8, context)),
                              Text(
                                'محادثة',
                                style: AppStyles.styleBold(12, context),
                              ),
                            ],
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
      },
    );
  }
}
