import 'package:families/Utils/Constants/app_styles.dart';
import 'package:flutter/material.dart';

import '../../Utils/Constants/app_images.dart';
import '../../Utils/Constants/app_size.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSize.widthSize(25, context)),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
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
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Expanded(
                      child: SizedBox(height: AppSize.heightSize(50, context))),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(AppLocalizations.of(context)!.home_screen),
                  ),
                  SizedBox(height: AppSize.heightSize(50, context))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
