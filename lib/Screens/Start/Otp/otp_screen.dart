import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../Providers/login_register_manager.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Helprs/navigation_service.dart';
import '../../../Utils/Widgets/costum_snackbar.dart';
import '../../../Utils/Widgets/custom_loading_indicator.dart';
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
              _buildContent(context, otpManager),
              CustomLoadingIndicator(isVisible: otpManager.isApiCallProcess),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(
      BuildContext context, LoginAndRegisterManager otpManager) {
    return ListView(
      padding: EdgeInsets.all(AppSize.widthSize(25, context)),
      children: [
        SizedBox(height: AppSize.heightSize(100, context)),
        _buildHeader(context, otpManager),
        SizedBox(height: AppSize.widthSize(50, context)),
        _buildPinput(context, otpManager),
        SizedBox(height: AppSize.heightSize(50, context)),
        _buildConfirmButton(context, otpManager),
        _buildFooter(context, otpManager),
      ],
    );
  }

  Widget _buildHeader(
      BuildContext context, LoginAndRegisterManager otpManager) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.verify,
          style: AppStyles.styleBold(24, context),
        ),
        Text(
          '${AppLocalizations.of(context)!.sent_code_to} ${otpManager.registerRequestModel.phoneNumber}',
          style: AppStyles.styleRegular(14, context),
        ),
      ],
    );
  }

  Widget _buildPinput(
      BuildContext context, LoginAndRegisterManager otpManager) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: AppSize.width(context),
          child: Pinput(
            length: 4,
            onCompleted: (value) async {
              otpManager.otpRequestModel.otp = int.parse(value);
            },
          ),
        ),
        SizedBox(height: AppSize.heightSize(5, context)),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            '00:${otpManager.seconds}',
            style: AppStyles.styleRegular(18, context),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(
      BuildContext context, LoginAndRegisterManager otpManager) {
    return ElevatedButton(
      onPressed: () async {
        if (otpManager.otpType == OTPType.confirm) {
          int? result = await otpManager.confirmOTP();
          safeShowErrorMessage(context, result);
        } else {
          await otpManager.getResetToken();
          //TODO reset password
        }
      },
      child: Text(AppLocalizations.of(context)!.confirm),
    );
  }

  Widget _buildFooter(
      BuildContext context, LoginAndRegisterManager otpManager) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (otpManager.seconds == 0)
          TextButton(
            onPressed: () async {
              if (otpManager.otpType == OTPType.confirm) {
                await otpManager.sendOtpForCreateAccount();
              } else {
                // TODO: send otp for reset
              }
            },
            child: Text(AppLocalizations.of(context)!.resend_code),
          ),
        TextButton(
          onPressed: () {
            NavigationService.goBack();
          },
          child: Text(AppLocalizations.of(context)!.edit_phone_number),
        ),
      ],
    );
  }
}
