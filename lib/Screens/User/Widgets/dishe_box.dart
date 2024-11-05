import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_links.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../View_models/families_store_viewmodel.dart';
import '../Screens/dish_view.dart';

class DisheBox extends StatelessWidget {
  final DishItemViewModel dish;
  final bool isStoreActive;

  const DisheBox({
    super.key,
    required this.dish,
    required this.isStoreActive,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(builder: (context, userManager, _) {
      return Container(
        decoration: BoxDecoration(
          color: Provider.of<AppSettingsProvider>(context).isDark
              ? AppColors.darkContainerBackground
              : Colors.white,
          borderRadius: BorderRadius.circular(AppSize.widthSize(12, context)),
          border: Border.all(color: const Color(0xFFE0E0E0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DisheView(dish: dish)),
            );
          },
          borderRadius: BorderRadius.circular(AppSize.widthSize(12, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImageSection(context),
              _buildDetailsSection(context),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildImageSection(BuildContext context) {
    return SizedBox(
      height: AppSize.heightSize(130, context),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.widthSize(12, context)),
              topRight: Radius.circular(AppSize.widthSize(12, context)),
            ),
            child: CachedNetworkImage(
              imageUrl: '${AppLinks.url}${dish.dishsImages!.first}',
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          if (!isStoreActive)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSize.widthSize(12, context)),
                  topRight: Radius.circular(AppSize.widthSize(12, context)),
                ),
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          Positioned(
            top: AppSize.heightSize(8, context),
            right: AppSize.widthSize(8, context),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.widthSize(8, context),
                vertical: AppSize.heightSize(4, context),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(AppSize.widthSize(8, context)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.black,
                    size: AppSize.iconSize(10, context),
                  ),
                  SizedBox(width: AppSize.widthSize(2, context)),
                  Text(
                    '${dish.preparationTime} د',
                    style: AppStyles.styleRegular(9, context).copyWith(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSize.widthSize(8, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dish.dishName!,
            style: AppStyles.styleBold(12, context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppSize.heightSize(4, context)),
          Text(
            '${dish.dishPrice} ريال',
            style: AppStyles.styleBold(11, context).copyWith(
              color: Colors.red,
            ),
          ),
          SizedBox(height: AppSize.heightSize(8, context)),
          Material(
            type: MaterialType.transparency,
            child: SizedBox(
              width: double.infinity,
              height: AppSize.heightSize(30, context),
              child: ElevatedButton(
                onPressed: isStoreActive
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => DisheView(dish: dish)),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: isStoreActive ? null : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSize.widthSize(6, context)),
                  ),
                ),
                child: Text(
                  'أكتشف',
                  style: AppStyles.styleBold(12, context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
