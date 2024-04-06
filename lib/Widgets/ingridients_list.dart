import 'package:families/Providers/app_settings_provider.dart';
import 'package:families/Widgets/ingridients_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_styles.dart';
import '../Models/ingridient_model.dart';

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
                  style: AppStyles.styleBold(context, 15),
                ),
                Text(
                  '${items.length} items',
                  style: AppStyles.styleMedium(context, 13).copyWith(
                    color: AppColors.greyTextColors,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: appSettings.width,
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
