import 'package:families/Constants/app_styles.dart';
import 'package:families/Models/ingridient_model.dart';
import 'package:families/Providers/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngridientsBox extends StatelessWidget {
  final IngridientModel ingridientModel;
  const IngridientsBox({
    super.key,
    required this.ingridientModel,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, appSettings, _) {
        return Container(
          width: appSettings.width < 600
              ? appSettings.height * 0.12
              : appSettings.height * 0.08,
          height: appSettings.width < 600
              ? appSettings.height * 0.2
              : appSettings.height * 0.15,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xff2C2F38),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(ingridientModel.image),
                Text(
                  ingridientModel.title,
                  style: AppStyles.styleMedium(context, 12),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
