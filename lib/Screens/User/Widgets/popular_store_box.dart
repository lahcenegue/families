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

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Screens/store_view.dart';

class PopularStoreBox extends StatelessWidget {
  final StoreItemViewModel store;
  final Function() addToFavorite;
  const PopularStoreBox({
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
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSize.widthSize(20, context)),
                    topRight: Radius.circular(AppSize.widthSize(20, context)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: '${AppLinks.url}${store.storeImage}',
                    width: AppSize.widthSize(220, context),
                    height: AppSize.heightSize(130, context),
                    fit: BoxFit.fitHeight,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  height: AppSize.heightSize(50, context),
                ),
              ],
            ),
            Positioned(
              top: 8,
              child: _buildRatingAndFavorite(context, userManager),
            ),
            Positioned(
              bottom: 0,
              child: _buildBottomPanel(context),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRatingAndFavorite(
      BuildContext context, UserManagerProvider userManager) {
    return Container(
      width: AppSize.widthSize(220, context),
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
        icon: (store.favorite ?? false)
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
      width: AppSize.widthSize(220, context),
      padding: EdgeInsets.all(AppSize.widthSize(8, context)),
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
              SizedBox(
                width: AppSize.widthSize(120, context),
                child: Text(
                  store.dishs.map((d) => d.dishName).join(', '),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: AppStyles.styleRegular(10, context),
                ),
              ),
              SizedBox(
                height: AppSize.heightSize(25, context),
                width: AppSize.widthSize(80, context),
                child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StoreView(store: store)));
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
