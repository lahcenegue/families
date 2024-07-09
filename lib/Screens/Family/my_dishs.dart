import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/app_settings_provider.dart';
import '../../Providers/family_manager_provider.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../Utils/Constants/app_size.dart';
import '../../Utils/Constants/app_styles.dart';
import '../../Utils/Helprs/navigation_service.dart';
import '../../View_models/my_dishs_viewmodel.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        AppLocalizations.of(context)!.my_dishes,
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
              AppLocalizations.of(context)!.add_dish,
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
        color: Provider.of<AppSettingsProvider>(context).isDark
            ? AppColors.darkContainerBackground
            : const Color(0xFFf5f5f5),
        borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.widthSize(10, context)),
            child: CachedNetworkImage(
              imageUrl: item.firstImage!,
              width: AppSize.widthSize(130, context),
              height: AppSize.heightSize(100, context),
              fit: BoxFit.fill,
              progressIndicatorBuilder: (context, url, progress) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(width: AppSize.widthSize(20, context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  item.itemName!,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: AppStyles.styleBold(14, context),
                ),
                Text(
                  item.description!,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  softWrap: false,
                  style: AppStyles.styleMedium(9, context).copyWith(),
                ),
                Text(
                  '${item.price} ${AppLocalizations.of(context)!.currency}',
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
