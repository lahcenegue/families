import 'package:families/Constants/app_strings.dart';
import 'package:families/Constants/app_styles.dart';
import 'package:families/Widgets/custom_backgound.dart';
import 'package:families/Widgets/custom_text_field.dart';
import 'package:families/Widgets/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/app_settings_provider.dart';
import '../../Providers/login_register_manager.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppSettingsProvider, LoginAndRegisterManager>(
      builder: (context, appsettings, registerManager, _) {
        return Scaffold(
          body: CustomBackground(
            child: SafeArea(
              child: ListView(
                children: [
                  SizedBox(height: appsettings.height * 0.1),
                  Text(
                    AppLocalizations.of(context)!.sign_up,
                    textAlign: TextAlign.center,
                    style: AppStyles.styleBold(context, 30),
                  ),
                  Text(
                    AppLocalizations.of(context)!.please_signup,
                    textAlign: TextAlign.center,
                    style: AppStyles.styleRegular(context, 16),
                  ),
                  SizedBox(height: appsettings.height * 0.06),
                  Container(
                    width: appsettings.width,
                    height: appsettings.height * 0.73,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(appsettings.width * 0.1),
                        topRight: Radius.circular(appsettings.width * 0.1),
                      ),
                    ),
                    child: ListView(
                      padding: EdgeInsets.all(appsettings.width * 0.07),
                      children: [
                        CustomTextField(
                          title: AppLocalizations.of(context)!.name,
                          hintText: AppLocalizations.of(context)!.name,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .password_entryPrompt; //TODO name
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: appsettings.height * 0.03),
                        CustomTextField(
                          title: AppLocalizations.of(context)!.email,
                          hintText: 'example@gmail.com',
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .password_entryPrompt; // TODO email
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: appsettings.height * 0.03),
                        CustomTextField(
                          title: AppLocalizations.of(context)!.password,
                          hintText: '******',
                          onChanged: (value) {
                            //registerManager.loginRequestModel.password = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .password_entryPrompt;
                            }
                            return null;
                          },
                          suffixIcon: registerManager.isVisible == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                          suffixChanged: () {
                            registerManager.togglePasswordVisibility();
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !registerManager.isVisible,
                        ),
                        SizedBox(height: appsettings.height * 0.03),
                        CustomTextField(
                          title: AppLocalizations.of(context)!.retype_password,
                          hintText: '******',
                          onChanged: (value) {
                            //registerManager.loginRequestModel.password = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .password_entryPrompt;
                            }
                            return null;
                          },
                          suffixIcon: registerManager.isVisible == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                          suffixChanged: () {
                            registerManager.togglePasswordVisibility();
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !registerManager.isVisible,
                        ),
                        SizedBox(height: appsettings.height * 0.05),
                        ElevatedButton(
                          onPressed: () {
                            if (registerManager.accountType ==
                                AppStrings.family) {
                              NavigationService.navigateTo(
                                  AppRoutes.registerFamilyScreen);
                            } else {
                              //TODO register
                            }
                          },
                          child: Text(
                            registerManager.accountType == AppStrings.family
                                ? AppLocalizations.of(context)!.continu
                                : AppLocalizations.of(context)!.sign_up,
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
