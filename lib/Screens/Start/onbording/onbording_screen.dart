import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/onbording_model.dart';
import '../../../Providers/app_settings_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_strings.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Widgets/dot_indicator.dart';
import '../../../Utils/Helprs/navigation_service.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBordingScreen extends StatelessWidget {
  const OnBordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Onboard> demoData = [
      Onboard(
        image: AppImages.onBordingImage1,
        title: 'title 1',
        description:
            '1 ipsum dolor sit amet consectetur. Donec at turpis semper neque.',
      ),
      Onboard(
        image: AppImages.onBordingImage2,
        title: 'title 1',
        description:
            '2 ipsum dolor sit amet consectetur. Donec at turpis semper neque.',
      ),
      Onboard(
        image: AppImages.onBordingImage3,
        title: 'title 1',
        description:
            '3 ipsum dolor sit amet consectetur. Donec at turpis semper neque.',
      ),
    ];
    return Consumer<AppSettingsProvider>(
      builder: (context, appsettings, _) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppSize.widthSize(20, context)),
              child: Column(
                children: [
                  _buildTopRow(context, appsettings, demoData.length),
                  _buildPageView(context, appsettings, demoData),
                  SizedBox(height: AppSize.heightSize(50, context)),
                  _buildBottomRow(context, appsettings, demoData),
                  SizedBox(height: AppSize.heightSize(30, context)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildTopRow(
    BuildContext context, AppSettingsProvider appsettings, int length) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildDotsIndicator(context, appsettings, length),
      Visibility(
        visible: appsettings.pageIndex != length - 1,
        child: TextButton(
          onPressed: () {
            appsettings.saveData(key: PrefKeys.onBording, value: 'watched');
            NavigationService.navigateTo(AppRoutes.accountTypeScreen);
          },
          child: Text(
            AppLocalizations.of(context)!.skip,
            style: AppStyles.styleMedium(16, context),
          ),
        ),
      )
    ],
  );
}

Widget _buildDotsIndicator(
    BuildContext context, AppSettingsProvider appsettings, int length) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      length,
      (index) => Padding(
        padding: EdgeInsets.only(right: AppSize.widthSize(10, context)),
        child: DotIndicator(isActive: index == appsettings.pageIndex),
      ),
    ),
  );
}

Widget _buildPageView(BuildContext context, AppSettingsProvider appsettings,
    List<Onboard> demoData) {
  return Expanded(
    child: PageView.builder(
      controller: appsettings.pageController,
      itemCount: demoData.length,
      onPageChanged: (index) => appsettings.getPageIndex(index),
      itemBuilder: (context, index) => OnBoardContent(
        image: demoData[index].image,
        title: demoData[index].title,
        descrition: demoData[index].description,
      ),
    ),
  );
}

Widget _buildBottomRow(BuildContext context, AppSettingsProvider appsettings,
    List<Onboard> demoData) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      if (appsettings.pageIndex > 0) _buildBackButton(context, appsettings),
      _buildNextButton(context, appsettings, demoData),
    ],
  );
}

Widget _buildBackButton(BuildContext context, AppSettingsProvider appsettings) {
  return InkWell(
    onTap: () => appsettings.pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    ),
    child: Container(
      height: AppSize.widthSize(60, context),
      padding: EdgeInsets.symmetric(horizontal: AppSize.widthSize(20, context)),
      decoration: BoxDecoration(
        color: const Color(0xFF37474f),
        borderRadius: BorderRadius.circular(AppSize.widthSize(10, context)),
      ),
      child: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: AppSize.iconSize(30, context),
      ),
    ),
  );
}

Widget _buildNextButton(BuildContext context, AppSettingsProvider appsettings,
    List<Onboard> demoData) {
  return InkWell(
    onTap: () {
      appsettings.pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      if (appsettings.pageIndex == demoData.length - 1) {
        NavigationService.navigateTo(AppRoutes.loginScreen);
        appsettings.saveData(key: PrefKeys.onBording, value: 'watched');
      }
    },
    child: Container(
      height: AppSize.widthSize(60, context),
      padding: EdgeInsets.symmetric(horizontal: AppSize.widthSize(20, context)),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(AppSize.widthSize(10, context)),
      ),
      child: Center(
        child: appsettings.pageIndex == demoData.length - 1
            ? Text(
                AppLocalizations.of(context)!.login,
                style: AppStyles.styleBold(14, context)
                    .copyWith(color: Colors.white),
              )
            : Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: AppSize.iconSize(30, context),
              ),
      ),
    ),
  );
}

class OnBoardContent extends StatelessWidget {
  final String image, title, descrition;
  const OnBoardContent({
    super.key,
    required this.image,
    required this.title,
    required this.descrition,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        SizedBox(
          width: AppSize.widthSize(245, context),
          child: AspectRatio(
            aspectRatio: .95,
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),
        ),
        const Spacer(flex: 1),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppStyles.styleBold(20, context).copyWith(),
        ),
        SizedBox(height: AppSize.heightSize(30, context)),
        Text(
          descrition,
          textAlign: TextAlign.center,
          style: AppStyles.styleRegular(16, context),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
