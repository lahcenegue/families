import 'package:families/Constants/app_colors.dart';
import 'package:families/Providers/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCircle extends StatelessWidget {
  final String image;
  const CustomCircle({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, appSettings, child) {
        return Container(
          width: appSettings.width * 0.12,
          height: appSettings.width * 0.12,
          padding: EdgeInsets.all(appSettings.width * 0.02),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Image.asset(
            image,
            color: AppColors.primaryColor,
          ),
        );
      },
    );
  }
}
