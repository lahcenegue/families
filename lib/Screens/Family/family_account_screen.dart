import 'package:cached_network_image/cached_network_image.dart';
import 'package:families/Utils/Helprs/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/login_register_manager.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Providers/family_manager_provider.dart';
import '../../Utils/Constants/app_links.dart';
import '../../Utils/Constants/app_strings.dart';

class FamilyAccountScreen extends StatelessWidget {
  const FamilyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppSettingsProvider, FamilyManagerProvider>(
      builder: (context, appSettings, familyManager, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.my_account,
              style: AppStyles.styleBold(16, context),
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSize.heightSize(50, context),
                    horizontal: AppSize.heightSize(20, context),
                  ),
                  child: Column(
                    children: [
                      _buildProfileImage(context, familyManager),
                      SizedBox(height: AppSize.heightSize(20, context)),
                      _buildProfileName(context, familyManager),
                      SizedBox(height: AppSize.heightSize(10, context)),
                      _buildPhoneNumber(context, familyManager),
                      SizedBox(height: AppSize.heightSize(50, context)),
                      _buildSettingsCard(context, appSettings),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileImage(
      BuildContext context, FamilyManagerProvider familyManager) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl:
            '${AppLinks.url}${familyManager.prefs!.getString(PrefKeys.profilImage)!}',
        width: AppSize.widthSize(100, context),
        height: AppSize.widthSize(100, context),
        fit: BoxFit.fill,
        progressIndicatorBuilder: (context, url, progress) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildProfileName(
      BuildContext context, FamilyManagerProvider familyManager) {
    return Text(
      familyManager.prefs!.getString(PrefKeys.storeName)!,
      style: AppStyles.styleBold(16, context),
    );
  }

  Widget _buildPhoneNumber(
      BuildContext context, FamilyManagerProvider familyManager) {
    return Text(
      familyManager.prefs!.getString(PrefKeys.phoneNumber)!,
      style: AppStyles.styleBold(16, context),
    );
  }

  Widget _buildSettingsCard(
      BuildContext context, AppSettingsProvider appSettings) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSize.widthSize(5, context)),
      decoration: BoxDecoration(
        color: appSettings.isDark
            ? AppColors.darkContainerBackground
            : Colors.white,
        borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
        border: Border.all(color: const Color(0xff9DB2CE).withOpacity(0.4)),
      ),
      child: Column(
        children: [
          _buildDarkModeTile(context, appSettings),
          _buildDivider(),
          _buildInfermationTile(context),
          _buildDivider(),
          _buildFeedbackTile(context),
          _buildDivider(),
          _buildTermsConditionsTile(context),
          _buildDivider(),
          _buildLogoutTile(context),
        ],
      ),
    );
  }

  Widget _buildDarkModeTile(
      BuildContext context, AppSettingsProvider appSettings) {
    return ListTile(
      title: Text(
        AppLocalizations.of(context)!.dark_mode,
        style: AppStyles.styleBold(12, context),
      ),
      trailing: Switch(
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: const Color(0xFFE8E8EA),
        inactiveThumbImage: AssetImage(AppImages.sunnyIcon),
        value: appSettings.theme == Brightness.dark,
        onChanged: (bool value) => appSettings.toggleTheme(),
      ),
    );
  }

  Widget _buildInfermationTile(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(
        'معلومات الخساب الشخصي',
        style: AppStyles.styleBold(12, context),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Theme.of(context).iconTheme.color,
        size: AppSize.iconSize(20, context),
      ),
    );
  }

  Widget _buildFeedbackTile(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(
        'التقييمات',
        style: AppStyles.styleBold(12, context),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Theme.of(context).iconTheme.color,
        size: AppSize.iconSize(20, context),
      ),
    );
  }

  Widget _buildLogoutTile(BuildContext context) {
    return ListTile(
      onTap: () {
        Provider.of<LoginAndRegisterManager>(context, listen: false).lougOut();
      },
      title: Text(
        AppLocalizations.of(context)!.logout,
        style: AppStyles.styleBold(12, context)
            .copyWith(color: const Color(0xFFC42C2C)),
      ),
    );
  }

  Widget _buildTermsConditionsTile(BuildContext context) {
    return ListTile(
      onTap: () {
        NavigationService.navigateTo(AppRoutes.familyTermsConditions);
      },
      title: Text(
        'الشروط و الاحكام',
        style: AppStyles.styleBold(12, context),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Theme.of(context).iconTheme.color,
        size: AppSize.iconSize(20, context),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: const Color(0xff9DB2CE).withOpacity(0.4));
  }
}
