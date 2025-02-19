import 'package:cached_network_image/cached_network_image.dart';
import 'package:families/Providers/app_settings_provider.dart';
import 'package:families/Providers/user_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/chat_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../View_models/my_ordres_viewmodel.dart';
import '../../Both/chat_screen.dart';
import 'review_screen.dart';

class MyOredresScreen extends StatefulWidget {
  const MyOredresScreen({super.key});

  @override
  State<MyOredresScreen> createState() => _MyOredresScreenState();
}

class _MyOredresScreenState extends State<MyOredresScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserManagerProvider>(context, listen: false).fetchMyOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<AppSettingsProvider, UserManagerProvider,
        ChatManagerProvider>(
      builder: (context, appSettings, userManager, chatManager, _) {
        return Scaffold(
          appBar: _buildAppBar(context, userManager),
          body: RefreshIndicator(
            onRefresh: () async {
              await userManager.fetchMyOrders();
            },
            child: _buildOrdersContent(context, userManager, chatManager),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(
    BuildContext context,
    UserManagerProvider userManager,
  ) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'طلباتي',
        style: AppStyles.styleBold(16, context),
      ),
    );
  }

  Widget _buildOrdersContent(
    BuildContext context,
    UserManagerProvider userManager,
    ChatManagerProvider chatManager,
  ) {
    if (userManager.isApiCallProcess) {
      return const Center(child: CircularProgressIndicator());
    } else if (userManager.myOrders == null) {
      return Center(
        child: Text(
          'لا توجد بيانات متاحة',
          style: AppStyles.styleBold(16, context),
        ),
      );
    } else if (userManager.myOrders!.customerOrders.isEmpty) {
      return Center(
        child: Text(
          'لا توجد طلبات',
          style: AppStyles.styleBold(16, context),
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.all(AppSize.widthSize(20, context)),
      itemCount: userManager.myOrders!.customerOrders.length,
      separatorBuilder: (context, index) =>
          SizedBox(height: AppSize.heightSize(20, context)),
      itemBuilder: (context, index) {
        CustomerOrdersViewModel customerOrders =
            userManager.myOrders!.customerOrders[index];
        return _buildOrderCard(context, customerOrders.customerName,
            customerOrders.orders, chatManager);
      },
    );
  }

  Widget _buildOrderCard(
    BuildContext context,
    String storeName,
    List<ItemViewModel> storeOrders,
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
                  storeName,
                  style: AppStyles.styleBold(14, context),
                ),
              ),
              SizedBox(
                width: AppSize.widthSize(80, context),
                height: AppSize.heightSize(30, context),
                child: OutlinedButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          id: storeOrders.first.storeId!,
                          title: storeOrders.first.storeName!,
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
          _buildOrderItemsList(context, storeOrders),
        ],
      ),
    );
  }

  Widget _buildOrderItemsList(
    BuildContext context,
    List<ItemViewModel> items,
  ) {
    return Column(
      children:
          items.map((item) => _buildOrderItemCard(context, item)).toList(),
    );
  }

  Widget _buildOrderItemCard(
    BuildContext context,
    ItemViewModel item,
  ) {
    return Container(
      width: AppSize.width(context),
      height: AppSize.heightSize(100, context),
      margin: EdgeInsets.only(top: AppSize.widthSize(10, context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.widthSize(10, context)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildItemImage(context, item.firstImage!),
          SizedBox(width: AppSize.widthSize(8, context)),
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
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSize.widthSize(5, context),
          horizontal: AppSize.widthSize(5, context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.itemName!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: AppStyles.styleBold(12, context)
                        .copyWith(color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddReviewScreen(item: item),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: AppSize.widthSize(30, context),
                    width: AppSize.widthSize(30, context),
                    child: Center(
                      child: Icon(
                        Icons.rate_review_outlined,
                        color: Colors.black,
                        size: AppSize.iconSize(25, context),
                      ),
                    ),
                  ),
                ),
              ],
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
                  item.formattedDate,
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
                _buildReceiveButton(context, item),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiveButton(BuildContext context, ItemViewModel item) {
    return SizedBox(
      width: AppSize.widthSize(90, context),
      height: AppSize.heightSize(30, context),
      child: ElevatedButton(
        onPressed: item.status == 2
            ? null
            : () => _showReceiveConfirmDialog(context, item),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              item.status == 2 ? Colors.grey : AppColors.primaryColor,
        ),
        child: Text(
          'استلام',
          style: AppStyles.styleBold(10, context),
        ),
      ),
    );
  }

  void _showReceiveConfirmDialog(BuildContext context, ItemViewModel item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'تأكيد الاستلام',
            style:
                AppStyles.styleBold(16, context).copyWith(color: Colors.black),
          ),
          content: Text(
            'هل تم إستلام طلبك بنجاح؟',
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
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                'تأكيد الاستلام',
                style: AppStyles.styleRegular(12, context)
                    .copyWith(color: Colors.black),
              ),
              onPressed: () => _confirmReceive(context, item),
            ),
          ],
        );
      },
    );
  }

  void _confirmReceive(BuildContext context, ItemViewModel item) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    String? result =
        await Provider.of<UserManagerProvider>(context, listen: false)
            .fulfillOrder(item.cartItemId!);

    if (context.mounted) {
      Navigator.of(context).pop(); // Close loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result ?? 'An error occurred'),
          duration: const Duration(seconds: 3),
        ),
      );

      Navigator.of(context).pop(); // Close confirm dialog
    }
  }
}


  //  SizedBox(
  //                 width: AppSize.widthSize(90, context),
  //                 height: AppSize.heightSize(30, context),
  //                 child: ElevatedButton(
  //                   onPressed: () {
  //                     item.status == 2
  //                         ? null
  //                         : showDialog(
  //                             context: context,
  //                             builder: (BuildContext context) {
  //                               return AlertDialog(
  //                                 title: Text(
  //                                   'تأكيد الاستلام',
  //                                   style: AppStyles.styleBold(16, context)
  //                                       .copyWith(color: Colors.black),
  //                                 ),
  //                                 content: Text(
  //                                   'هل تم إستلام طلبك بنجاح؟',
  //                                   style: AppStyles.styleRegular(14, context)
  //                                       .copyWith(color: Colors.black),
  //                                 ),
  //                                 actions: [
  //                                   TextButton(
  //                                     child: Text(
  //                                       'ليس بعد',
  //                                       style: AppStyles.styleBold(14, context)
  //                                           .copyWith(color: Colors.black),
  //                                     ),
  //                                     onPressed: () {
  //                                       Navigator.of(context).pop();
  //                                     },
  //                                   ),
  //                                   TextButton(
  //                                     child: Text(
  //                                       'تأكيد الاستلام',
  //                                       style:
  //                                           AppStyles.styleRegular(12, context)
  //                                               .copyWith(color: Colors.black),
  //                                     ),
  //                                     onPressed: () async {
  //                                       showDialog(
  //                                         context: context,
  //                                         barrierDismissible: false,
  //                                         builder: (BuildContext context) {
  //                                           return const Center(
  //                                               child:
  //                                                   CircularProgressIndicator());
  //                                         },
  //                                       );

  //                                       String? result = await Provider.of<
  //                                                   UserManagerProvider>(
  //                                               context,
  //                                               listen: false)
  //                                           .fulfillOrder(item.cartItemId!);

  //                                       if (context.mounted) {
  //                                         Navigator.of(context).pop();

  //                                         ScaffoldMessenger.of(context)
  //                                             .showSnackBar(
  //                                           SnackBar(
  //                                             content: Text(result ??
  //                                                 'An error occurred'),
  //                                             duration:
  //                                                 const Duration(seconds: 3),
  //                                           ),
  //                                         );

  //                                         Navigator.of(context).pop();
  //                                       }
  //                                     },
  //                                   ),
  //                                 ],
  //                               );
  //                             },
  //                           );
  //                   },
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: item.status == 2
  //                         ? Colors.grey
  //                         : AppColors.primaryColor,
  //                   ),
  //                   child: Text(
  //                     'استلام',
  //                     style: AppStyles.styleBold(10, context),
  //                   ),
  //                 ),
  //               ),
