import 'package:families/Utils/Constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Widgets/custom_backgound.dart';
import '../../../Utils/Widgets/dot_indicator.dart';
import '../../../Utils/Helprs/navigation_service.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBordingScreen extends StatelessWidget {
  const OnBordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Onboard> demoData = [
      Onboard(
        image: AppImages.food1,
        title: AppLocalizations.of(context)!.all_favorite,
        description:
            '1 ipsum dolor sit amet consectetur. Donec at turpis semper neque.',
      ),
      Onboard(
        image: AppImages.food2,
        title: AppLocalizations.of(context)!.all_favorite,
        description:
            '2 ipsum dolor sit amet consectetur. Donec at turpis semper neque.',
      ),
      Onboard(
        image: AppImages.food3,
        title: AppLocalizations.of(context)!.order_fromshef,
        description:
            '3 ipsum dolor sit amet consectetur. Donec at turpis semper neque.',
      ),
      Onboard(
        image: AppImages.food4,
        title: AppLocalizations.of(context)!.free_delivery,
        description:
            '4 ipsum dolor sit amet consectetur. Donec at turpis semper neque.',
      ),
    ];
    return Consumer<AppSettingsProvider>(
      builder: (context, appsettings, _) {
        return Scaffold(
          body: CustomBackground(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(AppSize.widthSize(20, context)),
                child: Column(
                  children: [
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
                    SizedBox(height: AppSize.heightSize(20, context)),
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
                    SizedBox(height: AppSize.heightSize(50, context)),
                    ElevatedButton(
                      onPressed: () {
                        appsettings.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                        if (appsettings.pageIndex == demoData.length - 1) {
                          NavigationService.navigateTo(
                              AppRoutes.accountTypeScreen);
                        }
                      },
                      child: Text(
                        appsettings.pageIndex == demoData.length - 1
                            ? AppLocalizations.of(context)!.get_started
                            : AppLocalizations.of(context)!.next,
                      ),
                    ),
                    SizedBox(
                      child: TextButton(
                        onPressed: () {
                          NavigationService.navigateTo(
                              AppRoutes.accountTypeScreen);
                        },
                        child: Text(AppLocalizations.of(context)!.skip,
                            style: AppStyles.styleRegular(context, 16).copyWith(
                              color:
                                  appsettings.pageIndex == demoData.length - 1
                                      ? Colors.transparent
                                      : Colors.white.withOpacity(0.7),
                            )),
                      ),
                    ),
                    SizedBox(height: AppSize.heightSize(10, context)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Onboard {
  final String image, title, description;
  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
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
    return Consumer<AppSettingsProvider>(builder: (context, appSettings, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(
            width: AppSize.widthSize(240, context),
            child: AspectRatio(
              aspectRatio: .82,
              child: SvgPicture.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const Spacer(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppStyles.styleBold(24, context),
          ),
          const SizedBox(height: 16),
          Text(
            descrition,
            textAlign: TextAlign.center,
            style: AppStyles.styleRegular(context, 16),
          ),
        ],
      );
    });
  }
}
