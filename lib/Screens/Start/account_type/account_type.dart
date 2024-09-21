import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/login_register_manager.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_strings.dart';
import '../../../Utils/Constants/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountType extends StatelessWidget {
  const AccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppSettingsProvider, LoginAndRegisterManager>(
      builder: (context, appSettings, loginManager, _) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppSize.widthSize(25, context)),
              child: CustomScrollView(
                slivers: [
                  _buildHeader(context),
                  _buildDescription(context),
                  _buildButtons(context, loginManager, appSettings),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: AppSize.heightSize(50, context)),
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
            style: AppStyles.styleBold(24, context)
                .copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(height: AppSize.heightSize(40, context)),
          Text(
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى،',
            textAlign: TextAlign.center,
            style: AppStyles.styleRegular(14, context),
          ),
          SizedBox(height: AppSize.heightSize(100, context)),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context,
      LoginAndRegisterManager loginManager, AppSettingsProvider appSettings) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              loginManager.toggleAccountType(AppStrings.user);
            },
            child: Text(AppLocalizations.of(context)!.login_user),
          ),
          SizedBox(height: AppSize.heightSize(20, context)),
          OutlinedButton(
            onPressed: () {
              loginManager.toggleAccountType(AppStrings.family);
            },
            child: Text(AppLocalizations.of(context)!.login_family),
          ),
          SizedBox(height: AppSize.heightSize(70, context)),
        ],
      ),
    );
  }
}
