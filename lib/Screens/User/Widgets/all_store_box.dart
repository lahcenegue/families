import 'package:cached_network_image/cached_network_image.dart';
import 'package:families/Utils/Constants/app_colors.dart';
import 'package:families/Utils/Constants/app_links.dart';
import 'package:families/Utils/Constants/app_size.dart';
import 'package:families/Utils/Constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Helprs/navigation_service.dart';
import '../../../View_models/families_store_viewmodel.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllStoreBox extends StatelessWidget {
  final StoreItemViewModel store;
  final Function() addToFavorite;
  const AllStoreBox({
    super.key,
    required this.store,
    required this.addToFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        return Stack(
          children: [
            _storeImage(context),
            Positioned(
              top: 8,
              right: 0,
              left: 0,
              child: _buildRatingAndFavorite(context, userManager),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: _buildBottomPanel(context),
            ),
          ],
        );
      },
    );
  }

  Widget _storeImage(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.widthSize(20, context)),
            topRight: Radius.circular(AppSize.widthSize(20, context)),
          ),
          child: CachedNetworkImage(
            imageUrl: '${AppLinks.url}${store.storeImage}',
            width: AppSize.width(context),
            height: AppSize.heightSize(150, context),
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, progress) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        SizedBox(
          height: AppSize.heightSize(60, context),
        ),
      ],
    );
  }

  Widget _buildRatingAndFavorite(
      BuildContext context, UserManagerProvider userManager) {
    return Container(
      width: AppSize.width(context),
      padding: EdgeInsets.symmetric(horizontal: AppSize.widthSize(8, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildRatingBox(context, store.storeRating!),
          _buildFavoriteIcon(context, userManager),
        ],
      ),
    );
  }

  Widget _buildRatingBox(BuildContext context, String rating) {
    return Container(
      height: AppSize.heightSize(30, context),
      width: AppSize.widthSize(60, context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.heightSize(25, context)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.star, color: AppColors.starColor),
          Text(
            rating,
            style: AppStyles.styleBold(12, context),
          )
        ],
      ),
    );
  }

  Widget _buildFavoriteIcon(
      BuildContext context, UserManagerProvider userManager) {
    return Container(
      height: AppSize.heightSize(30, context),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: IconButton(
        icon: store.favorite!
            ? const Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : const Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
        onPressed: addToFavorite,
      ),
    );
  }

  Widget _buildBottomPanel(BuildContext context) {
    return Container(
      width: AppSize.width(context),
      padding: EdgeInsets.all(AppSize.widthSize(10, context)),
      decoration: BoxDecoration(
        color: Provider.of<AppSettingsProvider>(context).isDark
            ? AppColors.darkContainerBackground
            : Colors.white,
        borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            store.storeName!,
            style: AppStyles.styleBold(14, context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                store.dishs.map((d) => d.dishName).join(', '),
                style: AppStyles.styleRegular(10, context),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: AppSize.heightSize(25, context),
                width: AppSize.widthSize(100, context),
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<UserManagerProvider>(context, listen: false)
                        .setSelectedStore(store);
                    NavigationService.navigateTo(AppRoutes.storeView);
                  },
                  child: FittedBox(
                    child: Text(AppLocalizations.of(context)!.discover),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
