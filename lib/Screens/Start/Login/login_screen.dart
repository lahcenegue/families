import 'package:families/Utils/Constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/login_register_manager.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_strings.dart';
import '../../../Utils/Constants/app_styles.dart';
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
            child: Padding(
              padding: EdgeInsets.all(AppSize.widthSize(25, context)),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
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
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
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
                        //Phone
                        CustomTextField(
                          title: AppLocalizations.of(context)!.email,
                          hintText: 'example@gmail.com',
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .password_entryPrompt;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: AppSize.heightSize(20, context)),

                        //Password
                        CustomTextField(
                          title: AppLocalizations.of(context)!.password,
                          hintText: '*********',
                          onChanged: (value) {
                            //loginManager.loginRequestModel.password = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .password_entryPrompt;
                            }
                            return null;
                          },
                          suffixIcon: loginManager.isVisible == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                          suffixChanged: () {
                            loginManager.togglePasswordVisibility();
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !loginManager.isVisible,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                AppLocalizations.of(context)!.forgot_password,
                                style: AppStyles.styleRegular(14, context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        Expanded(
                            child: SizedBox(
                                height: AppSize.heightSize(20, context))),
                        ElevatedButton(
                          onPressed: () {
                            if (loginManager.accountType == AppStrings.user) {
                              NavigationService.navigateToAndReplace(
                                  AppRoutes.userHomeScreen);
                            } else {
                              NavigationService.navigateToAndReplace(
                                  AppRoutes.familyHomeScreen);
                            }
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
                                NavigationService.navigateTo(
                                    AppRoutes.registerScreen);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.sign_up,
                                style:
                                    AppStyles.styleMedium(13, context).copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
