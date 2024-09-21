import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:families/Utils/Helprs/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_links.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_strings.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Widgets/costum_snackbar.dart';
import '../Widgets/all_store_box.dart';
import '../Widgets/popular_store_box.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserMainScreen extends StatelessWidget {
  const UserMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        return Padding(
          padding: EdgeInsets.only(top: AppSize.heightSize(20, context)),
          child: Scaffold(
            appBar: _buildAppBar(context, userManager),
            body: userManager.isApiCallProcess
                ? const Center(child: CircularProgressIndicator())
                : _buildContent(context, userManager),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, UserManagerProvider userManager) {
    return AppBar(
      title: ClipOval(
        child: CachedNetworkImage(
          imageUrl:
              '${AppLinks.url}${userManager.prefs!.getString(PrefKeys.profilImage)!}',
          width: AppSize.widthSize(50, context),
          height: AppSize.widthSize(50, context),
          fit: BoxFit.fill,
          progressIndicatorBuilder: (context, url, progress) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            NavigationService.navigateTo(AppRoutes.searchScreen);
          },
          icon: Icon(
            Icons.search,
            size: AppSize.iconSize(28, context),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, UserManagerProvider userManager) {
    return ListView(
      padding: EdgeInsets.all(AppSize.heightSize(20, context)),
      children: [
        _buildBannerImages(context, userManager),
        SizedBox(height: AppSize.heightSize(15, context)),
        _buildSectionTitle(context, AppLocalizations.of(context)!.popular),
        _buildPopularFamilies(context, userManager),
        _buildSectionTitle(context, AppLocalizations.of(context)!.all),
        _buildAllFamilies(context, userManager),
      ],
    );
  }

  Widget _buildPopularFamilies(
      BuildContext context, UserManagerProvider userManager) {
    return SizedBox(
      height: AppSize.heightSize(180, context),
      width: AppSize.width(context),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: userManager.popularFamiliesViewModel!.stores.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: AppSize.widthSize(10, context)),
        itemBuilder: (context, index) {
          return PopularStoreBox(
            store: userManager.popularFamiliesViewModel!.stores[index],
            addToFavorite: () async {
              await userManager
                  .addToFavorite(
                      storeId: userManager
                          .allFamiliesViewModel!.stores[index].storeId!)
                  .then(
                    (value) => customSnackBar(context, value),
                  );
            },
          );
        },
      ),
    );
  }

  Widget _buildAllFamilies(
      BuildContext context, UserManagerProvider userManager) {
    return SizedBox(
      width: AppSize.width(context),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: userManager.allFamiliesViewModel!.stores.length,
        separatorBuilder: (context, index) =>
            SizedBox(height: AppSize.heightSize(10, context)),
        itemBuilder: (context, index) => AllStoreBox(
          store: userManager.allFamiliesViewModel!.stores[index],
          addToFavorite: () async {
            await userManager
                .addToFavorite(
                    storeId: userManager
                        .allFamiliesViewModel!.stores[index].storeId!)
                .then((value) => customSnackBar(context, value));
          },
        ),
      ),
    );
  }

  Widget _buildBannerImages(
      BuildContext context, UserManagerProvider userManager) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        viewportFraction: 1,
        height: AppSize.heightSize(100, context),
        autoPlay: true,
        enableInfiniteScroll: false,
        autoPlayAnimationDuration: const Duration(seconds: 2),
        enlargeCenterPage: true,
      ),
      itemCount: userManager.bannerImages!.length,
      itemBuilder: (context, index, realIndex) {
        return CachedNetworkImage(
          imageUrl: userManager.bannerImages![index],
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSize.heightSize(15, context)),
      child: Text(title, style: AppStyles.styleBold(20, context)),
    );
  }
}
