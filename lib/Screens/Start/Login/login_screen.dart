import 'package:families/Constants/app_colors.dart';
import 'package:families/Constants/app_styles.dart';
import 'package:families/Providers/app_settings_provider.dart';
import 'package:families/Widgets/custom_backgound.dart';
import 'package:families/Widgets/custom_text_field.dart';
import 'package:families/Widgets/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Providers/login_register_manager.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppSettingsProvider, LoginAndRegisterManager>(
      builder: (context, appsettings, loginManager, _) {
        return Scaffold(
          body: CustomBackground(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: appsettings.height * 0.12),
                  Text(
                    AppLocalizations.of(context)!.login,
                    textAlign: TextAlign.center,
                    style: AppStyles.styleBold(context, 30),
                  ),
                  Text(
                    AppLocalizations.of(context)!.please_signin,
                    textAlign: TextAlign.center,
                    style: AppStyles.styleRegular(context, 16),
                  ),
                  const Expanded(child: SizedBox(height: 20)),
                  Container(
                    width: appsettings.width,
                    height: appsettings.height * 0.6,
                    padding: EdgeInsets.all(appsettings.width * 0.06),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(appsettings.width * 0.1),
                        topRight: Radius.circular(appsettings.width * 0.1),
                      ),
                    ),
                    child: CustomScrollView(
                      slivers: [
                        //Email
                        SliverToBoxAdapter(
                          child: CustomTextField(
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
                        ),
                        SliverToBoxAdapter(
                            child: SizedBox(height: appsettings.height * 0.03)),

                        //Password
                        SliverToBoxAdapter(
                          child: CustomTextField(
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
                        ),

                        SliverToBoxAdapter(
                          child: Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                              ),
                              Text(
                                AppLocalizations.of(context)!.remember_me,
                                style: AppStyles.styleRegular(context, 13)
                                    .copyWith(
                                  color: AppColors.fillColor,
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  AppLocalizations.of(context)!.forgot_password,
                                  style: AppStyles.styleRegular(context, 14)
                                      .copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
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
                                      height: appsettings.height * 0.05)),
                              ElevatedButton(
                                onPressed: () {},
                                child:
                                    Text(AppLocalizations.of(context)!.login),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(AppLocalizations.of(context)!
                                      .dont_haveAccount),
                                  TextButton(
                                    onPressed: () {
                                      NavigationService.navigateTo(
                                          AppRoutes.registerScreen);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.sign_up,
                                      style: AppStyles.styleBold(context, 14)
                                          .copyWith(
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
