import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/family_manager_provider.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../Utils/Constants/app_images.dart';
import '../../Utils/Constants/app_size.dart';
import '../../Utils/Constants/app_styles.dart';
import '../../View_models/my_ordres_viewmodel.dart';

class FamilyMainScreen extends StatelessWidget {
  const FamilyMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FamilyManagerProvider>(
      builder: (context, familyManager, _) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: familyManager.isApiCallProcess
                ? const Center(child: CircularProgressIndicator())
                : _buildTabBarView(context, familyManager),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: ClipOval(
        child: Image.asset(
          AppImages.userProfilImage,
          width: AppSize.widthSize(50, context),
          height: AppSize.widthSize(50, context),
          fit: BoxFit.cover,
        ),
      ),
      actions: [
        Container(
          padding: EdgeInsets.all(AppSize.widthSize(10, context)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.widthSize(50, context)),
            border: Border.all(color: AppColors.primaryColor),
          ),
          child: Center(
            child: Text('Address'),
          ),
        ),
        SizedBox(width: AppSize.widthSize(10, context)),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(AppSize.heightSize(100, context)),
        child: Container(
          height: AppSize.heightSize(60, context),
          margin: EdgeInsets.symmetric(
            horizontal: AppSize.widthSize(25, context),
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
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
              borderRadius:
                  BorderRadius.circular(AppSize.widthSize(25, context)),
            ),
            tabs: const [
              Tab(text: 'الطلبات'),
              Tab(text: 'المحادثات'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarView(
      BuildContext context, FamilyManagerProvider familyManager) {
    return TabBarView(
      children: [
        _buildOrdersContent(context, familyManager),
        _buildMessagesContent(context, familyManager),
      ],
    );
  }

  Widget _buildOrdersContent(
      BuildContext context, FamilyManagerProvider familyManager) {
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

  Widget _buildMessagesContent(
      BuildContext context, FamilyManagerProvider familyManager) {
    return Center(
      child: Text('Messages content goes here'),
    );
  }

  Widget _buildOrderCard(
      BuildContext context, String userName, List<ItemViewModel> items) {
    return Container(
      width: AppSize.width(context),
      padding: EdgeInsets.all(AppSize.widthSize(15, context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
        color: const Color(0xFFF5F5F5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderHeader(context, userName),
          SizedBox(height: AppSize.heightSize(20, context)),
          Text(
            'الطلب',
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
        Text(
          userName,
          style: AppStyles.styleBold(16, context),
        ),
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
        itemBuilder: (context, index) {
          return _buildOrderItemCard(context, items[index]);
        },
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
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(AppSize.widthSize(10, context)),
              child: Image.network(
                item.firstImage!,
                width: AppSize.widthSize(70, context),
                height: AppSize.heightSize(70, context),
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(width: AppSize.widthSize(10, context)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                item.itemName ?? 'Unknown Item',
                style: AppStyles.styleBold(10, context),
              ),
              Container(
                width: AppSize.widthSize(25, context),
                height: AppSize.widthSize(25, context),
                color: AppColors.primaryColor,
                child: Center(
                  child: Text(
                    item.amount.toString(),
                    style: AppStyles.styleBold(10, context).copyWith(
                      color: Colors.white,
                    ),
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
