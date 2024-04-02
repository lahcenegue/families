import 'package:families/Constants/app_colors.dart';
import 'package:families/Constants/app_images.dart';
import 'package:families/Constants/app_strings.dart';
import 'package:families/Constants/app_styles.dart';
import 'package:families/Providers/app_settings_provider.dart';
import 'package:families/Widgets/custom_backgound.dart';
import 'package:families/Widgets/custom_circle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/login_register_manager.dart';
import '../../Widgets/custom_container.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountType extends StatelessWidget {
  const AccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppSettingsProvider, LoginAndRegisterManager>(
      builder: (context, appSettings, loginManager, _) {
        return Scaffold(
          body: CustomBackground(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: appSettings.width * 0.2,
                  height: appSettings.width * 0.2,
                  child: Image.asset(
                    AppImages.logo,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: appSettings.height * 0.05),
                Text(
                  AppLocalizations.of(context)!.choose_you,
                  style: AppStyles.styleBold(context, 38).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: appSettings.height * 0.1),
                accountTypeBox(
                  appSettings: appSettings,
                  context: context,
                  onTap: () {
                    loginManager.toggleAccountType(AppStrings.family);
                  },
                  image: AppImages.personsIcon,
                  title: AppLocalizations.of(context)!.productive_family,
                ),
                SizedBox(height: appSettings.height * 0.05),
                accountTypeBox(
                  appSettings: appSettings,
                  context: context,
                  onTap: () {
                    loginManager.toggleAccountType(AppStrings.user);
                  },
                  image: AppImages.personIcon,
                  title: AppLocalizations.of(context)!.user,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  InkWell accountTypeBox({
    required AppSettingsProvider appSettings,
    required BuildContext context,
    required Function() onTap,
    required String image,
    required String title,
  }) {
    return InkWell(
      onTap: onTap,
      child: CustomContainer(
        child: Row(
          children: [
            CustomCircle(
              image: image,
            ),
            SizedBox(width: appSettings.width * 0.03),
            Text(
              title,
              style: AppStyles.styleRegular(context, 15),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
