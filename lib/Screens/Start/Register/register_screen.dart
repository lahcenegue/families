import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/login_register_manager.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Widgets/costum_snackbar.dart';
import '../../../Utils/Widgets/custom_loading_indicator.dart';
import '../../../Utils/Widgets/custom_text_field.dart';
import '../../../Utils/Helprs/navigation_service.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginAndRegisterManager>(
      builder: (context, registerManager, _) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.widthSize(25, context),
                  ),
                  child: Form(
                    key: registerManager.registerFormKey,
                    child: CustomScrollView(
                      slivers: [
                        _buildProfileImage(context, registerManager),
                        _buildRegisterForm(context, registerManager),
                        _buildFooter(context, registerManager),
                      ],
                    ),
                  ),
                ),
                CustomLoadingIndicator(
                  isVisible: registerManager.isApiCallProcess,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileImage(
    BuildContext context,
    LoginAndRegisterManager registerManager,
  ) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(height: AppSize.widthSize(50, context)),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryColor,
                width: 3,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ClipOval(
                    child: registerManager.storeImage != null
                        ? Image.file(
                            registerManager.storeImage!,
                            width: AppSize.widthSize(100, context),
                            height: AppSize.widthSize(100, context),
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            AppImages.storeProfilImage,
                            width: AppSize.widthSize(100, context),
                            height: AppSize.widthSize(100, context),
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: AppSize.widthSize(100, context),
                    height: AppSize.widthSize(100, context),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppColors.primaryColor.withOpacity(0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                        onPressed: () {
                          registerManager.pickProfileImage();
                        },
                        icon: Icon(
                          Icons.photo_camera,
                          color: AppColors.primaryColor,
                          size: AppSize.iconSize(28, context),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterForm(
    BuildContext context,
    LoginAndRegisterManager registerManager,
  ) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSize.heightSize(50, context)),
          Text(
            AppLocalizations.of(context)!.sign_up,
            style: AppStyles.styleBold(24, context),
          ),
          Text(
            AppLocalizations.of(context)!.please_signup,
            textAlign: TextAlign.center,
            style: AppStyles.styleRegular(16, context),
          ),
          SizedBox(height: AppSize.heightSize(30, context)),
          _buildTextFields(context, registerManager),
          _buildCheckbox(context, registerManager),
        ],
      ),
    );
  }

  Widget _buildTextFields(
    BuildContext context,
    LoginAndRegisterManager registerManager,
  ) {
    return Column(
      children: [
        CustomTextField(
          title: AppLocalizations.of(context)!.name,
          hintText: AppLocalizations.of(context)!.name,
          onChanged: (value) {
            registerManager.registerRequestModel.userName = value;
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.name_entryPrompt;
            }
            return null;
          },
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: AppSize.heightSize(20, context)),
        CustomTextField(
          title: AppLocalizations.of(context)!.phone,
          hintText: '050 505 505',
          onChanged: (value) {
            registerManager.registerRequestModel.phoneNumber = int.parse(value);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.phone_entryPrompt;
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
            registerManager.registerRequestModel.password = value;
            registerManager.firstPasword(value);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.password_entryPrompt;
            }
            return null;
          },
          suffixIcon: registerManager.isVisible
              ? Icons.visibility_off
              : Icons.visibility,
          suffixChanged: () {
            registerManager.toggleVisibility(fieldIndex: 1);
          },
          keyboardType: TextInputType.visiblePassword,
          obscureText: !registerManager.isVisible,
        ),
        SizedBox(height: AppSize.heightSize(20, context)),
        CustomTextField(
          title: AppLocalizations.of(context)!.retype_password,
          hintText: '*********',
          onChanged: (value) {},
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.password_entryPrompt;
            }
            if (value != registerManager.checkPassrowd) {
              return AppLocalizations.of(context)!.password_mismatch;
            }
            return null;
          },
          suffixIcon: registerManager.isVisible2
              ? Icons.visibility_off
              : Icons.visibility,
          suffixChanged: () {
            registerManager.toggleVisibility(fieldIndex: 2);
          },
          keyboardType: TextInputType.visiblePassword,
          obscureText: !registerManager.isVisible2,
        ),
      ],
    );
  }

  Widget _buildCheckbox(
    BuildContext context,
    LoginAndRegisterManager registerManager,
  ) {
    return Row(
      children: [
        Checkbox(
          value: registerManager.isAgree,
          onChanged: (value) {
            registerManager.toggleIsAgree(value!);
          },
        ),
        SizedBox(
          width: AppSize.widthSize(240, context),
          child: Text(
            AppLocalizations.of(context)!.agree_terms_conditions,
            style: AppStyles.styleRegular(12, context),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(
    BuildContext context,
    LoginAndRegisterManager registerManager,
  ) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        children: [
          Expanded(child: SizedBox(height: AppSize.heightSize(50, context))),
          ElevatedButton(
            onPressed: () async {
              await registerManager
                  .register()
                  .then((value) => customSnackBar(context, value));
            },
            child: Text(AppLocalizations.of(context)!.sign_up),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.have_account,
                style: AppStyles.styleMedium(13, context),
              ),
              TextButton(
                onPressed: () {
                  NavigationService.goBack();
                },
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: AppStyles.styleMedium(13, context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.heightSize(50, context)),
        ],
      ),
    );
  }
}
