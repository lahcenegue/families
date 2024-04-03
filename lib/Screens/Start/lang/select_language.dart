import 'package:families/Constants/app_colors.dart';
import 'package:families/Constants/app_images.dart';
import 'package:families/Constants/app_styles.dart';
import 'package:families/Providers/app_settings_provider.dart';
import 'package:families/Widgets/custom_backgound.dart';
import 'package:families/Widgets/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, appSettings, _) {
        return Scaffold(
          body: CustomBackground(
            child: Padding(
              padding: EdgeInsets.all(appSettings.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.g_translate,
                    color: Colors.white,
                    size: 100,
                  ),
                  SizedBox(
                    height: appSettings.width * 0.04,
                  ),
                  Text(
                    AppLocalizations.of(context)!.choose_lang,
                    style: AppStyles.styleBold(context, 22),
                  ),
                  Text(
                    AppLocalizations.of(context)!.select_lang,
                    style: AppStyles.styleRegular(context, 14),
                  ),
                  SizedBox(height: appSettings.width * 0.2),
                  Row(
                    children: [
                      Container(
                        width: appSettings.width * 0.16,
                        height: appSettings.width * 0.16,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.fillColor,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          AppImages.arabicFlag,
                        ),
                      ),
                      SizedBox(width: appSettings.width * 0.025),
                      TextButton(
                        onPressed: () {
                          NavigationService.navigateTo(
                              AppRoutes.onBordingScreen);
                          appSettings.toggleLocale(const Locale('ar'));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.arabic,
                          style: AppStyles.styleMedium(context, 28),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: appSettings.width * 0.05),
                  const Divider(),
                  SizedBox(height: appSettings.width * 0.05),
                  Row(
                    children: [
                      Container(
                        width: appSettings.width * 0.16,
                        height: appSettings.width * 0.16,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.fillColor,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          AppImages.englishFlag,
                        ),
                      ),
                      SizedBox(width: appSettings.width * 0.025),
                      TextButton(
                        onPressed: () {
                          NavigationService.navigateTo(
                              AppRoutes.onBordingScreen);
                          appSettings.toggleLocale(const Locale('en'));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.english,
                          style: AppStyles.styleMedium(context, 28),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
