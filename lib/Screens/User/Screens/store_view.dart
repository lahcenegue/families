import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_links.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../View_models/families_store_viewmodel.dart';
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
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              store.storeName ?? '',
              style: AppStyles.styleBold(18, context),
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.all(AppSize.widthSize(25, context)),
                  child: Column(
                    children: [
                      _buildStoreImage(context, store.storeImage),
                      SizedBox(height: AppSize.heightSize(25, context)),
                      _buildStoreDetails(context, store),
                      SizedBox(height: AppSize.heightSize(12, context)),
                      _buildDishsSection(context, store),
                      SizedBox(height: AppSize.heightSize(40, context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStoreImage(BuildContext context, String? imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
      child: CachedNetworkImage(
        imageUrl: '${AppLinks.url}$imageUrl',
        width: AppSize.width(context),
        height: AppSize.heightSize(230, context),
        fit: BoxFit.fill,
        progressIndicatorBuilder: (context, url, progress) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildStoreDetails(BuildContext context, StoreItemViewModel store) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  Widget _buildDishsSection(BuildContext context, StoreItemViewModel store) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'الاطباق',
              style: AppStyles.styleBold(16, context),
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
                SizedBox(width: AppSize.widthSize(15, context)),
            itemBuilder: (context, index) => DisheBox(dish: store.dishs[index]),
          ),
        ),
      ],
    );
  }
}
