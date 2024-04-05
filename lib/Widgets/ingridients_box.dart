import 'package:families/Constants/app_styles.dart';
import 'package:families/Providers/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngridientsBox extends StatelessWidget {
  final String image;
  final String title;
  const IngridientsBox({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(builder: (context, appSettings, _) {
      return Container(
        width: 70,
        height: 100,
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
              Image.asset(image),
              Text(
                title,
                style: AppStyles.styleMedium(context, 12),
              )
            ],
          ),
        ),
      );
    });
  }
}
