import 'package:families/Providers/family_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/app_settings_provider.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../Utils/Constants/app_images.dart';
import '../../Utils/Constants/app_size.dart';
import '../../Utils/Constants/app_styles.dart';
import 'family_account_screen.dart';
import 'family_main_screen.dart';
import 'my_dishs.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FamilyHomeScreen extends StatelessWidget {
  const FamilyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppSettingsProvider, FamilyManagerProvider>(
      builder: (context, appSettings, familyManager, _) {
        if (familyManager.isApiCallProcess) {
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
                    AppLocalizations.of(context)!.loading_data,
                    style: AppStyles.styleMedium(14, context),
                  ),
                ],
              ),
            ),
          );
        } else if (familyManager.isDataInitialized) {
          return Scaffold(
            bottomNavigationBar:
                _buildBottomNavigationBar(context, appSettings),
            body: Center(child: _getPage(appSettings.pageIndex)),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text(
                AppLocalizations.of(context)!.error_loading_data,
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
      AppLocalizations.of(context)!.orders,
      AppLocalizations.of(context)!.my_dishes,
      AppLocalizations.of(context)!.my_account,
    ];
    List<String> icons = [
      AppImages.cartIcon,
      AppImages.storeIcon,
      AppImages.accountIcon,
    ];

    return List.generate(3, (index) {
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
      FamilyMainScreen(),
      MyDishsScreen(),
      FamilyAccountScreen(),
    ];
    return pages[pageIndex];
  }
}
