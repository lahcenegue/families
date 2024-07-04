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

class FamilyHomeScreen extends StatelessWidget {
  const FamilyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, appSettings, _) {
        return Scaffold(
          bottomNavigationBar: _buildBottomNavigationBar(context, appSettings),
          body: Stack(
            children: [
              Center(child: _getPage(appSettings.pageIndex)),
              // if (userManager.isLoading)
              //   const CustomLoadingIndicator(isVisible: true),
              // if (userManager.errorMessage != null)
              //   ErrorDisplay(errorMessage: userManager.errorMessage),
            ],
          ),
        );
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
      'الطلبات',
      'اطباقي',
      'حسابي',
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
