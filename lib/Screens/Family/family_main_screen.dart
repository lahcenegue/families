import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/app_settings_provider.dart';
import '../../Providers/family_manager_provider.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../Utils/Constants/app_links.dart';
import '../../Utils/Constants/app_size.dart';
import '../../Utils/Constants/app_strings.dart';
import '../../Utils/Constants/app_styles.dart';
import '../../View_models/my_ordres_viewmodel.dart';
import '../Both/all_messages_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FamilyMainScreen extends StatelessWidget {
  const FamilyMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FamilyManagerProvider>(
      builder: (context, familyManager, _) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: _buildAppBar(context, familyManager),
            body: familyManager.isApiCallProcess
                ? const Center(child: CircularProgressIndicator())
                : _buildTabBarView(context, familyManager),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(
      BuildContext context, FamilyManagerProvider familyManager) {
    return AppBar(
      title: _buildProfileImage(context, familyManager),
      actions: [
        _buildLocationBadge(context, familyManager),
        SizedBox(width: AppSize.widthSize(10, context)),
      ],
      bottom: _buildTabBar(context),
    );
  }

  Widget _buildProfileImage(
      BuildContext context, FamilyManagerProvider familyManager) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl:
            '${AppLinks.url}${familyManager.prefs!.getString(PrefKeys.profilImage)!}',
        width: AppSize.widthSize(50, context),
        height: AppSize.widthSize(50, context),
        fit: BoxFit.fill,
        progressIndicatorBuilder: (context, url, progress) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildLocationBadge(
      BuildContext context, FamilyManagerProvider familyManager) {
    return Container(
      padding: EdgeInsets.all(AppSize.widthSize(8, context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.widthSize(50, context)),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Center(
        child: Text(
          familyManager.prefs!.getString(PrefKeys.storeLocation)!,
          style: AppStyles.styleMedium(12, context),
        ),
      ),
    );
  }

  PreferredSize _buildTabBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(AppSize.heightSize(100, context)),
      child: Container(
        height: AppSize.heightSize(60, context),
        margin:
            EdgeInsets.symmetric(horizontal: AppSize.widthSize(25, context)),
        decoration: BoxDecoration(
          color: Provider.of<AppSettingsProvider>(context).isDark
              ? AppColors.darkContainerBackground
              : const Color(0xFFf5f5f5),
          borderRadius: BorderRadius.circular(AppSize.widthSize(50, context)),
        ),
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.all(AppSize.widthSize(10, context)),
          labelColor: Colors.black,
          unselectedLabelColor: AppColors.greyTextColors,
          labelStyle: AppStyles.styleBold(12, context),
          unselectedLabelStyle: AppStyles.styleBold(12, context),
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSize.widthSize(25, context)),
          ),
          tabs: [
            Tab(text: AppLocalizations.of(context)!.orders),
            Tab(text: AppLocalizations.of(context)!.conversations),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBarView(
      BuildContext context, FamilyManagerProvider familyManager) {
    return TabBarView(
      children: [
        _buildOrdersContent(context, familyManager),
        const AllMessagesScreen(),
      ],
    );
  }

  Widget _buildOrdersContent(
      BuildContext context, FamilyManagerProvider familyManager) {
    if (familyManager.myOrders == null ||
        familyManager.myOrders!.users.isEmpty) {
      return Center(
        child: Text(
          'لا توجد طلبات',
          style: AppStyles.styleBold(16, context),
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.all(AppSize.widthSize(25, context)),
      itemCount: familyManager.myOrders?.users.length ?? 0,
      separatorBuilder: (context, index) =>
          SizedBox(height: AppSize.heightSize(20, context)),
      itemBuilder: (context, index) {
        String userName = familyManager.myOrders!.userNames[index];
        List<ItemViewModel> items = familyManager.myOrders!.users[userName]!;
        return _buildOrderCard(context, userName, items);
      },
    );
  }

  Widget _buildOrderCard(
      BuildContext context, String userName, List<ItemViewModel> items) {
    return Container(
      width: AppSize.width(context),
      padding: EdgeInsets.all(AppSize.widthSize(15, context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
        color: Provider.of<AppSettingsProvider>(context).isDark
            ? AppColors.darkContainerBackground
            : const Color(0xFFf5f5f5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderHeader(context, userName),
          SizedBox(height: AppSize.heightSize(20, context)),
          Text(
            AppLocalizations.of(context)!.order,
            style: AppStyles.styleBold(12, context),
          ),
          SizedBox(height: AppSize.heightSize(10, context)),
          _buildOrderItemsList(context, items),
          SizedBox(height: AppSize.heightSize(20, context)),
        ],
      ),
    );
  }

  Widget _buildOrderHeader(BuildContext context, String userName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(userName, style: AppStyles.styleBold(16, context)),
        Text(
          'time',
          style: AppStyles.styleMedium(12, context)
              .copyWith(color: AppColors.greyTextColors),
        ),
      ],
    );
  }

  Widget _buildOrderItemsList(BuildContext context, List<ItemViewModel> items) {
    return SizedBox(
      height: AppSize.heightSize(70, context),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: AppSize.widthSize(20, context)),
        itemBuilder: (context, index) =>
            _buildOrderItemCard(context, items[index]),
      ),
    );
  }

  Widget _buildOrderItemCard(BuildContext context, ItemViewModel item) {
    return Container(
      width: AppSize.widthSize(200, context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.widthSize(10, context)),
      ),
      child: Row(
        children: [
          if (item.firstImage != null)
            _buildItemImage(context, item.firstImage!),
          SizedBox(width: AppSize.widthSize(15, context)),
          _buildItemDetails(context, item),
        ],
      ),
    );
  }

  Widget _buildItemImage(BuildContext context, String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.widthSize(10, context)),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: AppSize.widthSize(70, context),
        height: AppSize.heightSize(70, context),
        fit: BoxFit.fill,
        progressIndicatorBuilder: (context, url, progress) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildItemDetails(BuildContext context, ItemViewModel item) {
    return SizedBox(
      width: AppSize.widthSize(100, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${item.itemName}',
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style:
                AppStyles.styleBold(10, context).copyWith(color: Colors.black),
          ),
          Container(
            width: AppSize.widthSize(25, context),
            height: AppSize.widthSize(25, context),
            color: AppColors.primaryColor,
            child: Center(
              child: Text(
                item.amount.toString(),
                style: AppStyles.styleBold(10, context)
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
