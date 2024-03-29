import 'package:families/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constants/app_images.dart';
import '../../Providers/app_settings_provider.dart';
import '../../Widgets/custom_backgound.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, appSettings, _) {
        return Scaffold(
          body: CustomBackground(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.logo,
                  width: appSettings.width * 0.8,
                ),
                Text(
                  'مأكول',
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: appSettings.width * 0.13),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
