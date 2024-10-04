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
            body: RefreshIndicator(
              onRefresh: () => userManager.initializeData(),
              child: _buildBody(context, userManager),
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, UserManagerProvider userManager) {
    return AppBar(
      title: userManager.isLoggedIn
          ? _buildUserProfileImage(context, userManager)
          : const SizedBox.shrink(),
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

  Widget _buildBody(BuildContext context, UserManagerProvider userManager) {
    if (userManager.isApiCallProcess) {
      return const Center(child: CircularProgressIndicator());
    }
    if (userManager.errorMessage != null) {
      return _buildErrorWidget(context, userManager);
    }
    return _buildContent(context, userManager);
  }

  Widget _buildErrorWidget(
      BuildContext context, UserManagerProvider userManager) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(AppSize.widthSize(20, context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: AppSize.iconSize(60, context),
                color: Colors.red,
              ),
              SizedBox(height: AppSize.heightSize(40, context)),
              Text(
                'خطأ في تحميل البيانات. يرجى التحقق من اتصال الإنترنت الخاص بك.',
                style: AppStyles.styleMedium(16, context),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSize.heightSize(40, context)),
              ElevatedButton.icon(
                onPressed: () => userManager.initializeData(),
                icon: const Icon(Icons.refresh),
                label: Text(
                  'إعادة المحاولة',
                  style: AppStyles.styleBold(14, context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileImage(
      BuildContext context, UserManagerProvider userManager) {
    final String? profileImageUrl =
        userManager.prefs?.getString(PrefKeys.profilImage);

    return Visibility(
      visible: profileImageUrl != null,
      child: profileImageUrl != null
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: '${AppLinks.url}$profileImageUrl',
                width: AppSize.widthSize(50, context),
                height: AppSize.widthSize(50, context),
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, progress) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildContent(BuildContext context, UserManagerProvider userManager) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
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
    if (userManager.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (userManager.popularFamiliesViewModel == null ||
        userManager.popularFamiliesViewModel!.stores.isEmpty) {
      return Center(
        child: Text(
          'لا توجد عائلات شعبية متاحة',
          style: AppStyles.styleMedium(14, context),
        ),
      );
    }
    return SizedBox(
      height: AppSize.heightSize(180, context),
      width: AppSize.width(context),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: userManager.popularFamiliesViewModel!.stores.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: AppSize.widthSize(15, context)),
        itemBuilder: (context, index) {
          return PopularStoreBox(
            store: userManager.popularFamiliesViewModel!.stores[index],
            addToFavorite: () async {
              if (await userManager.checkLoginStatus()) {
                await userManager
                    .addToFavorite(
                        storeId: userManager
                            .popularFamiliesViewModel!.stores[index].storeId!)
                    .then(
                  (value) {
                    if (context.mounted) {
                      safeShowErrorMessage(context, value);
                    }
                  },
                );
              } else {
                if (context.mounted) {
                  _showLoginDialog(context, userManager);
                }
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildAllFamilies(
      BuildContext context, UserManagerProvider userManager) {
    if (userManager.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (userManager.allFamiliesViewModel == null ||
        userManager.allFamiliesViewModel!.stores.isEmpty) {
      return Center(
        child: Text(
          'لا توجد عائلات متاحة',
          style: AppStyles.styleMedium(14, context),
        ),
      );
    }
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
            if (await userManager.checkLoginStatus()) {
              await userManager
                  .addToFavorite(
                      storeId: userManager
                          .allFamiliesViewModel!.stores[index].storeId!)
                  .then((value) => safeShowErrorMessage(context, value));
            } else {
              _showLoginDialog(context, userManager);
            }
          },
        ),
      ),
    );
  }

  Widget _buildBannerImages(
      BuildContext context, UserManagerProvider userManager) {
    if (userManager.bannerImages == null || userManager.bannerImages!.isEmpty) {
      return SizedBox(height: AppSize.heightSize(100, context));
    }
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

  void _showLoginDialog(BuildContext context, UserManagerProvider userManager) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'تسجيل الدخول مطلوب',
            textAlign: TextAlign.center,
            style: AppStyles.styleBold(16, context),
          ),
          content: Text(
            'يرجى تسجيل الدخول لإتمام هذا الإجراء',
            textAlign: TextAlign.center,
            style: AppStyles.styleMedium(14, context),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'رجوع',
                style: AppStyles.styleMedium(14, context),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.login,
                style: AppStyles.styleBold(14, context),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                NavigationService.navigateTo(AppRoutes.accountTypeScreen);
              },
            ),
          ],
        );
      },
    );
  }
}
