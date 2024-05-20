import 'package:families/Utils/Constants/app_size.dart';
import 'package:flutter/material.dart';

import '../../../Utils/Constants/app_images.dart';
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
    return SizedBox(
      width: AppSize.width(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildLogo(context),
          SizedBox(height: AppSize.heightSize(20, context)),
          _buildAppName(context),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return SizedBox(
      width: AppSize.widthSize(180, context),
      height: AppSize.widthSize(200, context),
      child: Image.asset(
        AppImages.logo,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildAppName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.app_name,
      style: AppStyles.styleExtraBold(52, context),
    );
  }
}
