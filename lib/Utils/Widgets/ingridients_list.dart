import 'package:families/Providers/app_settings_provider.dart';
import 'package:families/Utils/Widgets/ingridients_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/ingridient_model.dart';
import '../Constants/app_colors.dart';
import '../Constants/app_size.dart';
import '../Constants/app_styles.dart';

class IngridientsList extends StatelessWidget {
  final List<IngridientModel> items;
  const IngridientsList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, appSettings, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ingrigients',
                  style: AppStyles.styleBold(15, context),
                ),
                Text(
                  '${items.length} items',
                  style: AppStyles.styleMedium(13, context).copyWith(
                    color: AppColors.greyTextColors,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: AppSize.width(context),
              height: appSettings.width < 600
                  ? appSettings.height * 0.16
                  : appSettings.height * 0.14,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                separatorBuilder: (context, index) => const SizedBox(width: 15),
                itemBuilder: (context, index) {
                  return IngridientsBox(ingridientModel: items[index]);
                },
              ),
            )
          ],
        );
      },
    );
  }
}
