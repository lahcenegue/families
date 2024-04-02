import 'package:families/Constants/app_colors.dart';
import 'package:families/Providers/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, appSettings, _) {
        return Container(
          width: appSettings.width,
          margin: EdgeInsets.symmetric(horizontal: appSettings.width * 0.03),
          padding: EdgeInsets.symmetric(
            vertical: appSettings.width * 0.04,
            horizontal: appSettings.width * 0.05,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(appSettings.width * 0.05),
            color: AppColors.fillColor,
          ),
          child: child,
        );
      },
    );
  }
}
