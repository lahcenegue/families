import 'package:families/Screens/User/Screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Widgets/custom_loading_indicator.dart';
import '../../../Utils/Widgets/error_desplay.dart';
import 'all_families_store.dart';
import 'my_account_screen.dart';
import 'user_main_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppSettingsProvider, UserManagerProvider>(
      builder: (context, appSettings, userManager, _) {
        if (userManager.isApiCallProcess) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSize.widthSize(30, context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LinearProgressIndicator(),
                  SizedBox(height: AppSize.heightSize(20, context)),
                  Text(
                    'جارٍ تحميل البيانات، يرجى الانتظار...',
                    style: AppStyles.styleMedium(14, context),
                  ),
                ],
              ),
            ),
          );
        } else if (userManager.isDataInitialized) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            bottomNavigationBar:
                _buildBottomNavigationBar(context, appSettings),
            body: Stack(
              children: [
                Center(child: _getPage(appSettings.pageIndex)),
                if (userManager.isLoading)
                  const CustomLoadingIndicator(isVisible: true),
                if (userManager.errorMessage != null)
                  ErrorDisplay(errorMessage: userManager.errorMessage),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text(
                'Error loading data',
                style: AppStyles.styleMedium(14, context),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildBottomNavigationBar(
      BuildContext context, AppSettingsProvider appSettings) {
    return BottomNavigationBar(
      selectedLabelStyle: AppStyles.styleBold(10, context),
      items: _buildNavItems(context, appSettings),
      currentIndex: appSettings.pageIndex,
      onTap: appSettings.getPageIndex,
    );
  }

  List<BottomNavigationBarItem> _buildNavItems(
      BuildContext context, AppSettingsProvider appSettings) {
    List<String> labels = [
      AppLocalizations.of(context)!.home,
      AppLocalizations.of(context)!.cart,
      AppLocalizations.of(context)!.productive_family,
      AppLocalizations.of(context)!.account,
    ];
    List<String> icons = [
      AppImages.homeIcon,
      AppImages.cartIcon,
      AppImages.storeIcon,
      AppImages.accountIcon,
    ];

    return List.generate(4, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(
          icons[index],
          width: AppSize.widthSize(24, context),
          color: appSettings.pageIndex == index
              ? AppColors.primaryColor
              : appSettings.isDark
                  ? Colors.white
                  : const Color(0xff9DB2CE),
        ),
        label: labels[index],
      );
    });
  }

  Widget _getPage(int pageIndex) {
    const pages = [
      UserMainScreen(),
      CartScreen(),
      AllFamiliesStore(),
      MyAccountScreen(),
    ];
    return pages[pageIndex];
  }
}
