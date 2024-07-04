import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/login_register_manager.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';

class UserAccountScreen extends StatelessWidget {
  const UserAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, appSettings, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.account,
              style: AppStyles.styleBold(18, context),
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
                      _buildProfileImage(context),
                      SizedBox(height: AppSize.heightSize(20, context)),
                      _buildProfileName(context),
                      SizedBox(height: AppSize.heightSize(10, context)),
                      _buildPhoneNumber(context),
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

  Widget _buildProfileImage(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        AppImages.userProfilImage,
        width: AppSize.widthSize(90, context),
        height: AppSize.widthSize(90, context),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildProfileName(BuildContext context) {
    return Text(
      'عبد الله عبد الرحيم',
      style: AppStyles.styleBold(16, context),
    );
  }

  Widget _buildPhoneNumber(BuildContext context) {
    return Text(
      '+670001876',
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
          _buildFavoritesTile(context),
          _buildDivider(),
          _buildPurchasesTile(context),
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

  Widget _buildFavoritesTile(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(
        AppLocalizations.of(context)!.favorites,
        style: AppStyles.styleBold(12, context),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Theme.of(context).iconTheme.color,
        size: AppSize.iconSize(20, context),
      ),
    );
  }

  Widget _buildPurchasesTile(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(
        AppLocalizations.of(context)!.purchases,
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

  Widget _buildDivider() {
    return Divider(color: const Color(0xff9DB2CE).withOpacity(0.4));
  }
}
