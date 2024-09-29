import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_links.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Helprs/navigation_service.dart';
import '../../../View_models/families_store_viewmodel.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DisheBox extends StatelessWidget {
  final DishItemViewModel dish;

  const DisheBox({
    super.key,
    required this.dish,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(builder: (context, userManager, _) {
      return GestureDetector(
        onTap: () {
          userManager.setSelectedDish(dish);
          NavigationService.navigateTo(AppRoutes.disheView);
        },
        child: Stack(
          children: [
            Column(
              children: [
                _buildImage(context),
                SizedBox(height: AppSize.heightSize(50, context)),
              ],
            ),
            Positioned(
              bottom: 0,
              child: _buildBottomPanel(context, userManager),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppSize.widthSize(20, context)),
        topRight: Radius.circular(AppSize.widthSize(20, context)),
      ),
      child: CachedNetworkImage(
        imageUrl: '${AppLinks.url}${dish.dishsImages!.first}',
        width: AppSize.widthSize(230, context),
        height: AppSize.heightSize(120, context),
        fit: BoxFit.fill,
        progressIndicatorBuilder: (context, url, progress) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildBottomPanel(
      BuildContext context, UserManagerProvider userManager) {
    final appSettings = Provider.of<AppSettingsProvider>(context);
    return Container(
      width: AppSize.widthSize(230, context),
      padding: EdgeInsets.all(AppSize.widthSize(10, context)),
      decoration: BoxDecoration(
        color: appSettings.isDark
            ? AppColors.darkContainerBackground
            : Colors.white,
        borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDishName(context),
          _buildPriceAndButton(context, userManager),
        ],
      ),
    );
  }

  Widget _buildDishName(BuildContext context) {
    return Text(
      dish.dishName!,
      style: AppStyles.styleBold(14, context),
    );
  }

  Widget _buildPriceAndButton(
      BuildContext context, UserManagerProvider userManager) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${dish.dishPrice.toString()} ريال',
            style: AppStyles.styleBold(15, context).copyWith(
              color: Colors.red,
            ),
          ),
        ),
        SizedBox(
          height: AppSize.heightSize(25, context),
          width: AppSize.widthSize(80, context),
          child: ElevatedButton(
            onPressed: () {
              userManager.setSelectedDish(dish);
              NavigationService.navigateTo(AppRoutes.disheView);
            },
            child: FittedBox(
              child: Text(AppLocalizations.of(context)!.discover),
            ),
          ),
        ),
      ],
    );
  }
}
