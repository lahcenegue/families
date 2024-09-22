import 'package:cached_network_image/cached_network_image.dart';
import 'package:families/Providers/user_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/login_register_manager.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_links.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_strings.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Helprs/navigation_service.dart';

class UserAccountScreen extends StatelessWidget {
  const UserAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<AppSettingsProvider, UserManagerProvider,
        LoginAndRegisterManager>(
      builder: (context, appSettings, userManager, deleteAccountManager, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.my_account,
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
                      _buildProfileImage(context, userManager),
                      SizedBox(height: AppSize.heightSize(20, context)),
                      _buildProfileName(context, userManager),
                      SizedBox(height: AppSize.heightSize(10, context)),
                      _buildPhoneNumber(context, userManager),
                      SizedBox(height: AppSize.heightSize(50, context)),
                      _buildSettingsCard(
                          context, appSettings, deleteAccountManager),
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
      BuildContext context, UserManagerProvider userManager) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl:
            '${AppLinks.url}${userManager.prefs!.getString(PrefKeys.profilImage)!}',
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
      BuildContext context, UserManagerProvider userManager) {
    return Text(
      userManager.prefs!.getString(PrefKeys.userName)!,
      style: AppStyles.styleBold(16, context),
    );
  }

  Widget _buildPhoneNumber(
      BuildContext context, UserManagerProvider userManager) {
    return Text(
      userManager.prefs!.getString(PrefKeys.phoneNumber)!,
      style: AppStyles.styleBold(16, context),
    );
  }

  Widget _buildSettingsCard(
      BuildContext context,
      AppSettingsProvider appSettings,
      LoginAndRegisterManager deleteAccountManager) {
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
          // _buildFavoritesTile(context),
          // _buildDivider(),
          // _buildPurchasesTile(context),
          // _buildDivider(),
          _buildChatTile(context),
          _buildDivider(),
          _buildTermsConditionsTile(context),
          _buildDivider(),
          _deleteAccount(context, deleteAccountManager),
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

  Widget _buildChatTile(BuildContext context) {
    return ListTile(
      onTap: () {
        NavigationService.navigateTo(AppRoutes.userAllMessages);
      },
      title: Text(
        'الرسائل',
        style: AppStyles.styleBold(12, context),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Theme.of(context).iconTheme.color,
        size: AppSize.iconSize(20, context),
      ),
    );
  }

  Widget _buildTermsConditionsTile(BuildContext context) {
    return ListTile(
      onTap: () {
        NavigationService.navigateTo(AppRoutes.userTermsConditions);
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

  Widget _buildLogoutTile(BuildContext context) {
    return ListTile(
      onTap: () async {
        await Provider.of<LoginAndRegisterManager>(context, listen: false)
            .lougOut();
      },
      title: Text(
        AppLocalizations.of(context)!.logout,
        style: AppStyles.styleBold(12, context)
            .copyWith(color: const Color(0xFFC42C2C)),
      ),
    );
  }

  Widget _deleteAccount(
      BuildContext context, LoginAndRegisterManager deleteAccountManager) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'تأكيد الحذف',
                style: AppStyles.styleBold(16, context)
                    .copyWith(color: Colors.black),
              ),
              content: Text(
                'هل تريد حقًا حذف حسابك بشكل دائم؟',
                style: AppStyles.styleRegular(14, context)
                    .copyWith(color: Colors.black),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'إلغاء',
                    style: AppStyles.styleBold(14, context)
                        .copyWith(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'تأكيد الحذف',
                    style: AppStyles.styleRegular(12, context)
                        .copyWith(color: Colors.black),
                  ),
                  onPressed: () {
                    deleteAccountManager.deleteAccount();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      title: Text(
        'حذف الحساب',
        style: AppStyles.styleBold(12, context),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: const Color(0xff9DB2CE).withOpacity(0.4));
  }
}
