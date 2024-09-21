import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/login_register_manager.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_strings.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Widgets/costum_snackbar.dart';
import '../../../Utils/Widgets/custom_loading_indicator.dart';
import '../../../Utils/Widgets/custom_text_field.dart';
import '../../../Utils/Helprs/navigation_service.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginAndRegisterManager>(
      builder: (context, loginManager, _) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppSize.widthSize(25, context)),
                  child: Form(
                    key: loginManager.loginFormKey,
                    child: CustomScrollView(
                      slivers: [
                        _buildHeader(context),
                        _buildLoginForm(context, loginManager),
                        _buildFooter(context, loginManager),
                      ],
                    ),
                  ),
                ),
                CustomLoadingIndicator(
                    isVisible: loginManager.isApiCallProcess),
              ],
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
          SizedBox(
            width: AppSize.widthSize(120, context),
            child: AspectRatio(
              aspectRatio: 0.82,
              child:
                  Image.asset(AppImages.accountTypeImage, fit: BoxFit.contain),
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

  Widget _buildLoginForm(
      BuildContext context, LoginAndRegisterManager loginManager) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSize.heightSize(20, context)),
          Text(
            AppLocalizations.of(context)!.login,
            style: AppStyles.styleBold(24, context),
          ),
          Text(
            AppLocalizations.of(context)!.please_signin,
            textAlign: TextAlign.center,
            style: AppStyles.styleRegular(16, context),
          ),
          SizedBox(height: AppSize.heightSize(30, context)),
          CustomTextField(
            title: AppLocalizations.of(context)!.phone,
            hintText: '050 505 505',
            onChanged: (value) {
              //print(value);
              if (value.isNotEmpty) {
                print(value);
                loginManager.loginRequestModel.phoneNumber = int.parse(value);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.password_entryPrompt;
              }
              return null;
            },
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: AppSize.heightSize(20, context)),
          CustomTextField(
            title: AppLocalizations.of(context)!.password,
            hintText: '*********',
            onChanged: (value) {
              loginManager.loginRequestModel.password = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.password_entryPrompt;
              }
              return null;
            },
            suffixIcon: loginManager.isVisible
                ? Icons.visibility_off
                : Icons.visibility,
            suffixChanged: () => loginManager.toggleVisibility(fieldIndex: 1),
            keyboardType: TextInputType.visiblePassword,
            obscureText: !loginManager.isVisible,
          ),
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () => _forgotPasswordShow(context, loginManager),
                child: Text(
                  AppLocalizations.of(context)!.forgot_password,
                  style: AppStyles.styleRegular(14, context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(
      BuildContext context, LoginAndRegisterManager loginManager) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        children: [
          Expanded(child: SizedBox(height: AppSize.heightSize(50, context))),
          ElevatedButton(
            onPressed: () async {
              await loginManager
                  .login()
                  .then((value) => customSnackBar(context, value));
            },
            child: Text(AppLocalizations.of(context)!.login),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.dont_haveAccount,
                style: AppStyles.styleMedium(13, context),
              ),
              TextButton(
                onPressed: () {
                  if (loginManager.accountType == AppStrings.user) {
                    NavigationService.navigateTo(AppRoutes.registerScreen);
                  } else {
                    NavigationService.navigateTo(
                        AppRoutes.familyRegisterScreen);
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.sign_up,
                  style: AppStyles.styleMedium(13, context)
                      .copyWith(color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.heightSize(50, context)),
        ],
      ),
    );
  }

  void _forgotPasswordShow(
      BuildContext context, LoginAndRegisterManager loginManager) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        return Container(
          padding: EdgeInsets.all(AppSize.widthSize(25, context)),
          height: AppSize.heightSize(300, context) + keyboardHeight,
          width: AppSize.width(context),
          decoration: BoxDecoration(
            color: Provider.of<AppSettingsProvider>(context).isDark
                ? AppColors.darkScaffoldBackground
                : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.widthSize(20, context)),
              topRight: Radius.circular(AppSize.widthSize(20, context)),
            ),
          ),
          child: Column(
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context)!.enter_phone_number,
                  style: AppStyles.styleBold(14, context),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: AppSize.heightSize(30, context)),
              TextFormField(
                onChanged: (value) {
                  loginManager.otpRequestModel.phoneNumber = int.parse(value);
                },
                decoration: const InputDecoration(hintText: '050 505 505'),
                keyboardType: TextInputType.phone,
              ),
              Expanded(
                  child: SizedBox(height: AppSize.heightSize(30, context))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: AppSize.width(context) * 0.4,
                    child: ElevatedButton(
                      onPressed: () async {
                        await loginManager.sendOTPForResetPassword();
                      },
                      child: Text(AppLocalizations.of(context)!.confirm),
                    ),
                  ),
                  SizedBox(
                    width: AppSize.width(context) * 0.4,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.5)),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        AppLocalizations.of(context)!.back,
                        style: AppStyles.styleBold(15, context)
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
