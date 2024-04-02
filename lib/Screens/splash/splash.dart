import 'package:families/Constants/app_images.dart';
import 'package:families/Constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                SizedBox(
                  width: appSettings.width * 0.7,
                  height: appSettings.width * 0.7,
                  child: Image.asset(
                    AppImages.logo,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'مأكول',
                  style: AppStyles.styleExtraBold(context, 52),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
