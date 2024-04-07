import 'package:families/Utils/Constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/login_register_manager.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_strings.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Widgets/custom_backgound.dart';
import '../../../Utils/Widgets/custom_circle.dart';
import '../../../Utils/Widgets/custom_container.dart';

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
                  width: AppSize.widthSize(100, context),
                  child: AspectRatio(
                    aspectRatio: 0.82,
                    child: Image.asset(
                      AppImages.logo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: AppSize.heightSize(30, context)),
                Text(
                  AppLocalizations.of(context)!.choose_you,
                  style: AppStyles.styleBold(38, context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: AppSize.heightSize(70, context)),
                accountTypeBox(
                  appSettings: appSettings,
                  context: context,
                  onTap: () {
                    loginManager.toggleAccountType(AppStrings.family);
                  },
                  image: AppImages.personsIcon,
                  title: AppLocalizations.of(context)!.productive_family,
                ),
                SizedBox(height: AppSize.heightSize(30, context)),
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
            SizedBox(width: AppSize.widthSize(10, context)),
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
