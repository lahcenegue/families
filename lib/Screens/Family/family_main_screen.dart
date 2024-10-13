import 'package:cached_network_image/cached_network_image.dart';
import 'package:families/Screens/Both/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/app_settings_provider.dart';
import '../../Providers/chat_manager_provider.dart';
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
    return Consumer2<FamilyManagerProvider, ChatManagerProvider>(
      builder: (context, familyManager, chatManager, _) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: _buildAppBar(context, familyManager),
            body: familyManager.isApiCallProcess
                ? const Center(child: CircularProgressIndicator())
                : _buildTabBarView(context, familyManager, chatManager),
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

  Widget _buildTabBarView(BuildContext context,
      FamilyManagerProvider familyManager, ChatManagerProvider chatManager) {
    return TabBarView(
      children: [
        _buildOrdersContent(context, familyManager, chatManager),
        const AllMessagesScreen(),
      ],
    );
  }

  Widget _buildOrdersContent(
    BuildContext context,
    FamilyManagerProvider familyManager,
    ChatManagerProvider chatManager,
  ) {
    if (familyManager.myOrders == null ||
        familyManager.myOrders!.ordres.isEmpty) {
      return Center(
        child: Text(
          'لا توجد طلبات',
          style: AppStyles.styleBold(16, context),
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.all(AppSize.widthSize(20, context)),
      itemCount: familyManager.myOrders?.ordres.length ?? 0,
      separatorBuilder: (context, index) =>
          SizedBox(height: AppSize.heightSize(20, context)),
      itemBuilder: (context, index) {
        String userName = familyManager
            .myOrders!.storeName[index]; // the key of the map in the response
        List<ItemViewModel> userOrders =
            familyManager.myOrders!.ordres[userName]!;
        return _buildOrderCard(context, userName, userOrders, chatManager);
      },
    );
  }

  Widget _buildOrderCard(
    BuildContext context,
    String userName,
    List<ItemViewModel> userOrders,
    ChatManagerProvider chatManager,
  ) {
    return Container(
      width: AppSize.width(context),
      padding: EdgeInsets.all(AppSize.widthSize(10, context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
        color: Provider.of<AppSettingsProvider>(context).isDark
            ? AppColors.darkContainerBackground
            : const Color(0xFFf5f5f5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: AppSize.widthSize(180, context),
                child: Text(
                  userName,
                  style: AppStyles.styleBold(14, context),
                ),
              ),
              SizedBox(
                width: AppSize.widthSize(80, context),
                height: AppSize.heightSize(30, context),
                child: OutlinedButton(
                  onPressed: () async {
                    print(chatManager.token);
                    //chatManager.fetchUserMessages(id: userOrders.first.userId!);
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          id: userOrders.first.userId!,
                          title: userOrders.first.userName!,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'تواصل',
                    style: AppStyles.styleBold(10, context),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.heightSize(5, context)),
          const Divider(),
          SizedBox(height: AppSize.heightSize(10, context)),
          _buildOrderItemsList(context, userOrders),
        ],
      ),
    );
  }

  Widget _buildOrderItemsList(
    BuildContext context,
    List<ItemViewModel> items,
  ) {
    return SizedBox(
      height: items.length *
          (AppSize.heightSize(100, context) + AppSize.heightSize(20, context)),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        reverse: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (context, index) =>
            SizedBox(height: AppSize.widthSize(20, context)),
        itemBuilder: (context, index) =>
            _buildOrderItemCard(context, items[index]),
      ),
    );
  }

  Widget _buildOrderItemCard(
    BuildContext context,
    ItemViewModel item,
  ) {
    return Container(
      width: AppSize.width(context),
      height: AppSize.heightSize(100, context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.widthSize(10, context)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
        width: AppSize.widthSize(100, context),
        height: AppSize.heightSize(100, context),
        fit: BoxFit.fill,
        progressIndicatorBuilder: (context, url, progress) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildItemDetails(BuildContext context, ItemViewModel item) {
    return Container(
      width: AppSize.widthSize(200, context),
      padding: EdgeInsets.only(left: AppSize.widthSize(5, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            item.itemName!,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: false,
            style:
                AppStyles.styleBold(12, context).copyWith(color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${item.amount} اطباق',
                style: AppStyles.styleRegular(10, context)
                    .copyWith(color: Colors.black),
              ),
              Text(
                item.date!,
                style: AppStyles.styleRegular(10, context)
                    .copyWith(color: Colors.black),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: AppSize.widthSize(90, context),
                height: AppSize.heightSize(30, context),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primaryColor,
                  ),
                  borderRadius:
                      BorderRadius.circular(AppSize.widthSize(10, context)),
                ),
                child: Center(
                  child: Text(
                    item.statusText,
                    style: AppStyles.styleRegular(10, context)
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: AppSize.widthSize(90, context),
                height: AppSize.heightSize(30, context),
                child: ElevatedButton(
                  onPressed: () {
                    item.status == 2
                        ? null
                        : showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'تأكيد الارسال',
                                  style: AppStyles.styleBold(16, context)
                                      .copyWith(color: Colors.black),
                                ),
                                content: Text(
                                  'هل الطلب جاهز للارسال؟',
                                  style: AppStyles.styleRegular(14, context)
                                      .copyWith(color: Colors.black),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      'ليس بعد',
                                      style: AppStyles.styleBold(14, context)
                                          .copyWith(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'تأكيد الارسال',
                                      style: AppStyles.styleRegular(12, context)
                                          .copyWith(color: Colors.black),
                                    ),
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                      );
                                      String? result = await Provider.of<
                                                  FamilyManagerProvider>(
                                              context,
                                              listen: false)
                                          .fulfillOrder(item.cartItemId!);

                                      if (context.mounted) {
                                        Navigator.of(context).pop();

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                result ?? 'An error occurred'),
                                            duration:
                                                const Duration(seconds: 3),
                                          ),
                                        );

                                        Navigator.of(context).pop();
                                      }
                                    },
                                  )
                                ],
                              );
                            },
                          );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        item.status == 2 ? Colors.grey : AppColors.primaryColor,
                  ),
                  child: Text(
                    'ارسال',
                    style: AppStyles.styleBold(10, context),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
