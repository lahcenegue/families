import 'package:families/Utils/Constants/app_colors.dart';
import 'package:families/Utils/Constants/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../Models/onbording_model.dart';
import '../../../Providers/app_settings_provider.dart';
import '../../../Utils/Constants/app_images.dart';
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            demoData.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(
                                  right: AppSize.widthSize(10, context)),
                              child: DotIndicator(
                                  isActive: index == appsettings.pageIndex),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: appsettings.pageIndex != demoData.length - 1,
                        child: TextButton(
                          onPressed: () {
                            NavigationService.navigateTo(
                                AppRoutes.accountTypeScreen);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.skip,
                            style: AppStyles.styleMedium(16, context).copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: appsettings.pageController,
                      itemCount: demoData.length,
                      onPageChanged: (index) {
                        appsettings.getPageIndex(index);
                      },
                      itemBuilder: (context, index) => OnBoardContent(
                        image: demoData[index].image,
                        title: demoData[index].title,
                        descrition: demoData[index].description,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.heightSize(50, context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: appsettings.pageIndex == 0 ? false : true,
                        child: InkWell(
                          onTap: () {
                            appsettings.pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                          child: Container(
                            height: AppSize.widthSize(60, context),
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSize.widthSize(20, context)),
                            decoration: BoxDecoration(
                              color: const Color(0xFF37474f),
                              borderRadius: BorderRadius.circular(
                                  AppSize.widthSize(10, context)),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: AppSize.iconSize(30, context),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          appsettings.pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                          if (appsettings.pageIndex == demoData.length - 1) {
                            NavigationService.navigateTo(AppRoutes.loginScreen);
                          }
                        },
                        child: Container(
                            height: AppSize.widthSize(60, context),
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSize.widthSize(20, context)),
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(
                                    AppSize.widthSize(10, context))),
                            child: Center(
                              child: appsettings.pageIndex ==
                                      demoData.length - 1
                                  ? Text(
                                      AppLocalizations.of(context)!.login,
                                      style: AppStyles.styleBold(14, context)
                                          .copyWith(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: AppSize.iconSize(30, context),
                                    ),
                            )),
                      ),
                    ],
                  ),
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
          style: AppStyles.styleBold(20, context).copyWith(
            color: Colors.black,
          ),
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
