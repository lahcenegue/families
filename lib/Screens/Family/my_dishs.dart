import 'package:families/Utils/Constants/app_colors.dart';
import 'package:families/Utils/Helprs/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/family_manager_provider.dart';
import '../../Utils/Constants/app_size.dart';
import '../../Utils/Constants/app_styles.dart';
import '../../View_models/my_dishs_viewmodel.dart';

class MyDishsScreen extends StatelessWidget {
  const MyDishsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FamilyManagerProvider>(
      builder: (context, familyManager, _) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: familyManager.isApiCallProcess
              ? const Center(child: CircularProgressIndicator())
              : _buildContent(context, familyManager),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'اطباقي',
        style: AppStyles.styleBold(14, context),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, FamilyManagerProvider familyManager) {
    return Padding(
      padding: EdgeInsets.all(AppSize.widthSize(25, context)),
      child: Column(
        children: [
          _buildAddDishButton(context),
          SizedBox(height: AppSize.heightSize(20, context)),
          Expanded(
            child: ListView.separated(
              itemCount: familyManager.myDishs!.items.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppSize.heightSize(20, context)),
              itemBuilder: (context, index) {
                MyDishViewModel item = familyManager.myDishs!.items[index];
                return _buildDishItem(context, item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddDishButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: AppSize.widthSize(150, context),
          child: ElevatedButton(
            onPressed: () {
              NavigationService.navigateTo(AppRoutes.addNewDish);
            },
            child: Text(
              '+ اضافة طبق',
              style: AppStyles.styleBold(14, context).copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDishItem(BuildContext context, MyDishViewModel item) {
    return Container(
      width: AppSize.width(context),
      padding: EdgeInsets.only(left: AppSize.widthSize(10, context)),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
      ),
      child: Row(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(AppSize.widthSize(10, context)),
          //   child: Image.network(
          //     item.firstImage!,
          //     width: AppSize.widthSize(100, context),
          //     height: AppSize.heightSize(100, context),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          SizedBox(width: AppSize.widthSize(10, context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  item.itemName ?? 'Unknown Item',
                  style: AppStyles.styleBold(14, context),
                ),
                Text(
                  item.description ?? 'No description',
                  style: AppStyles.styleBold(10, context).copyWith(
                    color: AppColors.greyTextColors,
                  ),
                ),
                Text(
                  '${item.price} ريال',
                  style: AppStyles.styleExtraBold(14, context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
