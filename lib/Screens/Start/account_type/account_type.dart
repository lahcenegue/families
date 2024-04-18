import 'package:families/Utils/Constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/login_register_manager.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_strings.dart';
import '../../../Utils/Constants/app_styles.dart';
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
          body: Container(
            width: AppSize.width(context),
            padding: EdgeInsets.all(AppSize.widthSize(25, context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: AppSize.widthSize(120, context),
                  child: AspectRatio(
                    aspectRatio: 0.82,
                    child: Image.asset(
                      AppImages.accountTypeImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                Text(
                  AppLocalizations.of(context)!.app_name,
                  style: AppStyles.styleBold(24, context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: AppSize.heightSize(40, context)),
                Text(
                  'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى،',
                  textAlign: TextAlign.center,
                  style: AppStyles.styleRegular(14, context),
                ),
                SizedBox(height: AppSize.heightSize(70, context)),
                ElevatedButton(
                  onPressed: () {
                    loginManager.toggleAccountType(AppStrings.family);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.login_user,
                    style: AppStyles.styleBold(14, context),
                  ),
                ),

                SizedBox(height: AppSize.heightSize(20, context)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    loginManager.toggleAccountType(AppStrings.user);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.logn_family,
                    style: AppStyles.styleBold(14, context).copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                // accountTypeBox(
                //   appSettings: appSettings,
                //   context: context,
                //   onTap: () {
                //     loginManager.toggleAccountType(AppStrings.user);
                //   },
                //   image: AppImages.personIcon,
                //   title: AppLocalizations.of(context)!.user,
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
