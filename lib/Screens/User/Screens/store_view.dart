import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_links.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../Widgets/dishe_box.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        final store = userManager.selectedStore;
        if (store == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: EdgeInsets.all(AppSize.widthSize(25, context)),
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppSize.widthSize(20, context)),
                child: CachedNetworkImage(
                  imageUrl: '${AppLinks.url}${store.storeImage}',
                  width: AppSize.width(context),
                  height: AppSize.heightSize(225, context),
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, progress) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(height: AppSize.heightSize(25, context)),
              Text(
                store.storeName!,
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
                    store.storeRating!,
                    style: AppStyles.styleBold(16, context),
                  ),
                ],
              ),
              SizedBox(height: AppSize.heightSize(12, context)),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'سعر التوصيل',
                      style: AppStyles.styleBold(16, context),
                    ),
                    TextSpan(
                      text: ' ${store.deliveryCost} ريال ',
                      style: AppStyles.styleBold(16, context)
                          .copyWith(color: Colors.red),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSize.heightSize(12, context)),
              Text(
                'نبذة',
                style: AppStyles.styleBold(16, context),
              ),
              Text(
                store.storeDescription!,
                style: AppStyles.styleRegular(12, context),
              ),
              SizedBox(height: AppSize.heightSize(12, context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الاطباق',
                    style: AppStyles.styleBold(16, context),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'عرض الكل',
                      style: AppStyles.styleBold(10, context)
                          .copyWith(color: AppColors.primaryColor),
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
                  itemCount: store.dishs.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: AppSize.widthSize(10, context)),
                  itemBuilder: (context, index) => DisheBox(
                    dish: store.dishs[index],
                  ),
                ),
              ),
              SizedBox(height: AppSize.heightSize(40, context)),
            ],
          ),
        );
      },
    );
  }
}
