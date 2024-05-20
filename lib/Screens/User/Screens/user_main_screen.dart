import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../Widgets/all_store_box.dart';
import '../Widgets/popular_store_box.dart';
import '../Widgets/search_bar.dart';
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
            appBar: _buildCustomAppBar(context),
            body: userManager.isApiCallProcess
                ? const Center(child: CircularProgressIndicator())
                : _buildContent(context, userManager),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, UserManagerProvider userManager) {
    return ListView(
      padding: EdgeInsets.all(AppSize.heightSize(20, context)),
      children: [
        SizedBox(height: AppSize.heightSize(25, context)),
        _buildBannerImages(context, userManager),
        SizedBox(height: AppSize.heightSize(15, context)),
        searchBar(context),
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

  AppBar _buildCustomAppBar(BuildContext context) {
    return AppBar(
      actions: [
        Container(
          width: AppSize.widthSize(150, context),
          height: AppSize.heightSize(40, context),
          margin:
              EdgeInsets.symmetric(horizontal: AppSize.widthSize(24, context)),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor, width: 1),
            borderRadius:
                BorderRadius.circular(AppSize.heightSize(44, context)),
          ),
          child: Center(
            child: Text(
              'حي الياسمين. الرياض',
              style: AppStyles.styleRegular(10, context),
            ),
          ),
        ),
      ],
    );
  }
}
