import 'package:families/Utils/Constants/app_size.dart';
import 'package:families/Utils/Constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../Providers/login_register_manager.dart';
import '../../Utils/Helprs/navigation_service.dart';
import '../../Utils/Widgets/custom_loading_indicator.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginAndRegisterManager>(
      builder: (context, otpManager, _) {
        return Scaffold(
          body: Stack(
            children: [
              ListView(
                padding: EdgeInsets.all(AppSize.widthSize(25, context)),
                children: [
                  SizedBox(height: AppSize.heightSize(100, context)),
                  Text(
                    AppLocalizations.of(context)!.verify,
                    style: AppStyles.styleBold(24, context),
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.sent_code_to} ${otpManager.otpRequestModel.phoneNumber}',
                    style: AppStyles.styleRegular(14, context),
                  ),
                  SizedBox(height: AppSize.widthSize(50, context)),

                  Pinput(
                    length: 6,
                    onCompleted: (value) async {
                      //otpManager.getOtp(int.parse(value));

                      // if (otpManager.otpType == 'confirmOtp') {
                      //   otpManager.confirmOtp();
                      // } else if (otpManager.otpType == 'resetOtp') {
                      //   NavigationService.navigateTo(AppRoutes.resetPassword);
                      // }
                    },
                  ),
                  SizedBox(height: AppSize.heightSize(5, context)),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('00:${otpManager.seconds}'),
                  ),

                  SizedBox(height: AppSize.heightSize(50, context)),

                  // button
                  ElevatedButton(
                    onPressed: () async {
                      // if (otpManager.otpType == 'confirmOtp') {
                      //   otpManager.confirmOtp();
                      // } else if (otpManager.otpType == 'resetOtp') {
                      //   NavigationService.navigateTo(AppRoutes.resetPassword);
                      // }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.confirm,
                      style: AppStyles.styleBold(14, context),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: otpManager.seconds == 0,
                        child: TextButton(
                          onPressed: () async {
                            //await otpManager.sendOtp(otpManager.otpToken!);
                          },
                          child:
                              Text(AppLocalizations.of(context)!.resend_code),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          NavigationService.goBack();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.edit_phone_number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              CustomLoadingIndicator(
                isVisible: otpManager.isApiCallProcess,
              ),
            ],
          ),
        );
      },
    );
  }
}
