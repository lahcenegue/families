import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/login_register_manager.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Widgets/costum_snackbar.dart';
import '../../../Utils/Widgets/custom_text_field.dart';
import '../../../Utils/Widgets/custom_loading_indicator.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginAndRegisterManager>(
      builder: (context, resetManager, _) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppSize.widthSize(25, context)),
                  child: Form(
                    key: resetManager.resetFormKey,
                    child: CustomScrollView(
                      slivers: [
                        _buildHeader(context),
                        _buildResetForm(context, resetManager),
                        _buildFooter(context, resetManager),
                      ],
                    ),
                  ),
                ),
                CustomLoadingIndicator(
                    isVisible: resetManager.isApiCallProcess),
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
        mainAxisAlignment: MainAxisAlignment.start,
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

  Widget _buildResetForm(
      BuildContext context, LoginAndRegisterManager resetManager) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSize.heightSize(20, context)),
          Text(
            AppLocalizations.of(context)!.rest_password,
            style: AppStyles.styleBold(24, context),
          ),
          Text(
            AppLocalizations.of(context)!.new_password,
            style: AppStyles.styleRegular(14, context),
          ),
          SizedBox(height: AppSize.heightSize(30, context)),

          //password
          CustomTextField(
            title: AppLocalizations.of(context)!.password,
            onChanged: (value) {
              resetManager.resetRequestModel.password = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.password_entryPrompt;
              }
              return null;
            },
            suffixIcon: resetManager.isVisible
                ? Icons.visibility_off
                : Icons.visibility,
            suffixChanged: () => resetManager.toggleVisibility(fieldIndex: 1),
            keyboardType: TextInputType.visiblePassword,
            hintText: AppLocalizations.of(context)!.password,
            obscureText: !resetManager.isVisible,
          ),
          SizedBox(height: AppSize.heightSize(20, context)),

          //Re-type password
          CustomTextField(
            title: AppLocalizations.of(context)!.retype_password,
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.password_entryPrompt;
              }
              if (value != resetManager.resetRequestModel.password) {
                return AppLocalizations.of(context)!.password_mismatch;
              }
              return null;
            },
            suffixIcon: resetManager.isVisible2
                ? Icons.visibility_off
                : Icons.visibility,
            suffixChanged: () => resetManager.toggleVisibility(fieldIndex: 2),
            keyboardType: TextInputType.visiblePassword,
            hintText: AppLocalizations.of(context)!.retype_password,
            obscureText: !resetManager.isVisible2,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(
      BuildContext context, LoginAndRegisterManager resetManager) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        children: [
          Expanded(child: SizedBox(height: AppSize.heightSize(50, context))),
          ElevatedButton(
            onPressed: () async {
              int? result = await resetManager.resetPassword();
              if (!context.mounted) return;
              safeShowErrorMessage(context, result);
            },
            child: Text(AppLocalizations.of(context)!.rest_password),
          ),
          SizedBox(height: AppSize.heightSize(50, context)),
        ],
      ),
    );
  }
}
