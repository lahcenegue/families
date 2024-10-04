import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final appSettings = Provider.of<AppSettingsProvider>(context);
    return SizedBox(
      width: AppSize.width(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildLogo(context, appSettings),
          _buildAppName(context),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context, AppSettingsProvider appSettings) {
    return SizedBox(
      width: AppSize.widthSize(220, context),
      height: AppSize.widthSize(240, context),
      child: Image.asset(
        AppImages.logo,
        color: appSettings.isDark ? Colors.white : AppColors.primaryColor,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildAppName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.app_name,
      style: AppStyles.styleExtraBold(40, context),
    );
  }
}
