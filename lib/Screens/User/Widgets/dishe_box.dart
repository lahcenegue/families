import 'package:cached_network_image/cached_network_image.dart';
import 'package:families/Utils/Constants/app_links.dart';
import 'package:families/Utils/Constants/app_size.dart';
import 'package:families/Utils/Constants/app_styles.dart';
import 'package:families/Utils/Helprs/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../View_models/families_store_viewmodel.dart';

class DisheBox extends StatelessWidget {
  final DishItemViewModel dish;

  const DisheBox({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.widthSize(20, context)),
                topRight: Radius.circular(AppSize.widthSize(20, context)),
              ),
              child: CachedNetworkImage(
                imageUrl: '${AppLinks.url}${dish.dishesImages.first}',
                width: AppSize.widthSize(230, context),
                height: AppSize.heightSize(120, context),
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, progress) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(
              height: AppSize.heightSize(50, context),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          child: _buildBottomPanel(context),
        ),
      ],
    );
  }

  Widget _buildBottomPanel(BuildContext context) {
    return Container(
      width: AppSize.widthSize(230, context),
      padding: EdgeInsets.all(AppSize.widthSize(10, context)),
      decoration: BoxDecoration(
        color: Provider.of<AppSettingsProvider>(context).isDark
            ? AppColors.darkContainerBackground
            : Colors.white,
        borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dish.disheName,
            style: AppStyles.styleBold(14, context),
          ),
          Row(
            children: [
              Expanded(
                child: Text('${dish.dishePrice.toString()} Rial',
                    style: AppStyles.styleBold(15, context).copyWith(
                      color: Colors.red,
                    )),
              ),
              SizedBox(
                height: AppSize.heightSize(25, context),
                width: AppSize.widthSize(80, context),
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<UserManagerProvider>(context, listen: false)
                        .setSelectedDish(dish);
                    NavigationService.navigateTo(AppRoutes.disheView);
                  },
                  child: FittedBox(
                      child: Text(AppLocalizations.of(context)!.discover)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
