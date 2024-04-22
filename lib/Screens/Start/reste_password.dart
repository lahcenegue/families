import 'package:families/Utils/Constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/login_register_manager.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Utils/Constants/app_styles.dart';
import '../../Utils/Widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginAndRegisterManager>(
      builder: (context, resteManager, _) {
        return Scaffold(
          body: Stack(
            children: [
              Form(
                key: resteManager.resetFormKey,
                child: ListView(
                  padding: EdgeInsets.all(AppSize.widthSize(25, context)),
                  children: [
                    SizedBox(height: AppSize.heightSize(100, context)),

                    Text(
                      AppLocalizations.of(context)!.rest_password,
                      style: AppStyles.styleBold(24, context),
                    ),

                    Text(
                      AppLocalizations.of(context)!.new_password,
                      style: AppStyles.styleRegular(14, context),
                    ),
                    SizedBox(height: AppSize.widthSize(50, context)),

                    // password 1
                    CustomTextField(
                      title: AppLocalizations.of(context)!.password,
                      onChanged: (value) {
                        //resteManager.resetRequestModel.password = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .password_entryPrompt;
                        }
                        return null;
                      },
                      suffixIcon: resteManager.isVisible == true
                          ? Icons.visibility_off
                          : Icons.visibility,
                      suffixChanged: () {
                        resteManager.toggleVisibility(fieldIndex: 1);
                      },
                      keyboardType: TextInputType.visiblePassword,
                      hintText: AppLocalizations.of(context)!.password,
                      obscureText: !resteManager.isVisible,
                    ),
                    SizedBox(height: AppSize.heightSize(20, context)),

                    // password 2
                    CustomTextField(
                      title: AppLocalizations.of(context)!.retype_password,
                      onChanged: (value) {
                        //resteManager.resetRequestModel.password = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .password_entryPrompt;
                        }
                        return null;
                      },
                      suffixIcon: resteManager.isVisible == true
                          ? Icons.visibility_off
                          : Icons.visibility,
                      suffixChanged: () {
                        resteManager.toggleVisibility(fieldIndex: 2);
                      },
                      keyboardType: TextInputType.visiblePassword,
                      hintText: AppLocalizations.of(context)!.password,
                      obscureText: !resteManager.isVisible2,
                    ),

                    SizedBox(height: AppSize.heightSize(50, context)),

                    // button
                    ElevatedButton(
                      onPressed: () async {
                        // await resteManager.restetPassword().then(
                        //       (value) => _handleResetResult(context, value),
                        //     );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.rest_password,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: resteManager.isApiCallProcess,
                child: Stack(
                  children: [
                    ModalBarrier(
                      color: Colors.white.withOpacity(0.6),
                      dismissible: true,
                    ),
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // void _handleResetResult(BuildContext context, String? result) {
  //   if (result == 'error') {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //           content: Text(AppLocalizations.of(context)!.registrationError)),
  //     );
  //   }
  // }
}
