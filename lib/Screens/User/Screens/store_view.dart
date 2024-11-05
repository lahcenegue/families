import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_links.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../View_models/families_store_viewmodel.dart';
import '../Widgets/dishe_box.dart';

class StoreView extends StatelessWidget {
  final StoreItemViewModel store;
  const StoreView({
    required this.store,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              store.storeName ?? '',
              style: AppStyles.styleBold(18, context),
            ),
          ),
          body: Stack(
            children: [
              ListView(
                padding: EdgeInsets.all(AppSize.widthSize(25, context)),
                children: [
                  _buildStoreImage(context, store.storeImage),
                  if (!store.isActive) _buildInactiveStoreIndicator(context),
                  SizedBox(height: AppSize.heightSize(25, context)),
                  _buildStoreDetails(context, store),
                  SizedBox(height: AppSize.heightSize(12, context)),
                  _buildDishsSection(context, store),
                  SizedBox(height: AppSize.heightSize(20, context)),
                ],
              ),
              if (!store.isActive)
                Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
                      color: Colors.black.withOpacity(0.03),
                    ),
                  ),
                ),
            ],
          ),
          bottomNavigationBar:
              !store.isActive ? _buildInactiveStoreBar(context) : null,
        );
      },
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
        color: Provider.of<AppSettingsProvider>(context).isDark
            ? AppColors.darkContainerBackground
            : Colors.white,
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
        Row(
          children: [
            Text(
              store.storeName!,
              style: AppStyles.styleBold(20, context),
            ),
            SizedBox(
              width: AppSize.widthSize(8, context),
            ),
            if (!store.isActive)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.widthSize(12, context),
                  vertical: AppSize.heightSize(4, context),
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppSize.widthSize(12, context)),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Text(
                  'مغلق',
                  style: AppStyles.styleBold(12, context).copyWith(
                    color: Colors.red,
                  ),
                ),
              )
          ],
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: AppSize.widthSize(12, context),
              mainAxisSpacing: AppSize.heightSize(12, context),
            ),
            itemCount: store.dishs.length,
            itemBuilder: (context, index) => DisheBox(
              dish: store.dishs[index],
              isStoreActive: store.isActive,
            ),
          ),
        ),
      ],
    );
  }
}
