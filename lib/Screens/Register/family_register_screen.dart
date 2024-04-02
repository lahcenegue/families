import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constants/app_styles.dart';
import '../../Providers/app_settings_provider.dart';
import '../../Providers/login_register_manager.dart';
import '../../Widgets/custom_backgound.dart';
import '../../Widgets/custom_text_field.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterFamilyScreen extends StatelessWidget {
  const RegisterFamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppSettingsProvider, LoginAndRegisterManager>(
      builder: (context, appsettings, registerManager, _) {
        return Scaffold(
          body: CustomBackground(
            child: SafeArea(
              child: ListView(
                children: [
                  SizedBox(height: appsettings.height * 0.05),
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
                  SizedBox(height: appsettings.height * 0.03),
                  Container(
                    width: appsettings.width,
                    height: appsettings.height * 0.8,
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
                          title: 'Name of shop',
                          hintText: 'store name',
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .storeName_entryPrompt;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: appsettings.height * 0.03),
                        CustomTextField(
                          title: 'Location',
                          hintText: 'Riadh',
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .location_entryPrompt;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: appsettings.height * 0.03),
                        CustomTextField(
                          title: 'Expected time for order',
                          hintText: '20 minutes',
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .time_entryPrompt;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: appsettings.height * 0.03),
                        CustomTextField(
                          title: 'Upload photo for store',
                          hintText: 'Upload photo',
                          onChanged: (value) {},
                          suffixIcon: Icons.cloud_upload,
                        ),
                        SizedBox(height: appsettings.height * 0.03),
                        CustomTextField(
                          title: 'Upload documents for store',
                          hintText: 'Upload documents',
                          onChanged: (value) {},
                          suffixIcon: Icons.cloud_upload,
                        ),
                        SizedBox(height: appsettings.height * 0.03),
                        CustomTextField(
                          title: 'Raising a health certificate',
                          hintText: 'Upload photo',
                          onChanged: (value) {},
                          suffixIcon: Icons.cloud_upload,
                        ),
                        SizedBox(height: appsettings.height * 0.05),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            AppLocalizations.of(context)!.sign_up,
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
