import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/login_register_manager.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Helprs/navigation_service.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginAndRegisterManager>(
      builder: (context, loginManager, _) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(AppSize.widthSize(25, context)),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildContent(context)),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildFooter(context, loginManager),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppSize.heightSize(100, context)),
        Text(
          AppLocalizations.of(context)!.verified_successfully,
          textAlign: TextAlign.start,
          style: AppStyles.styleBold(24, context),
        ),
        SizedBox(height: AppSize.heightSize(50, context)),
        SizedBox(
          width: AppSize.widthSize(200, context),
          child: AspectRatio(
            aspectRatio: 0.82,
            child: Image.asset(
              AppImages.congratulationsImage,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.congratulations,
          style: AppStyles.styleBold(22, context),
        ),
        SizedBox(height: AppSize.heightSize(20, context)),
        Text(
          AppLocalizations.of(context)!.account_ready,
          textAlign: TextAlign.center,
          style: AppStyles.styleRegular(14, context),
        ),
      ],
    );
  }

  Widget _buildFooter(
      BuildContext context, LoginAndRegisterManager loginManager) {
    return Column(
      children: [
        Expanded(child: SizedBox(height: AppSize.heightSize(50, context))),
        ElevatedButton(
          onPressed: () {
            NavigationService.navigateToAndReplace(AppRoutes.accountTypeScreen);
          },
          child: Text(
            'تسحيل الدخول',
            style: AppStyles.styleBold(14, context),
          ),
        ),
        SizedBox(height: AppSize.heightSize(50, context)),
      ],
    );
  }
}
