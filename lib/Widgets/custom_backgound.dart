import 'package:families/Constants/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../Providers/app_settings_provider.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  const CustomBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, appSettings, _) {
        return SizedBox(
          height: appSettings.height,
          width: appSettings.width,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  AppImages.cloud,
                  width: appSettings.width,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: child,
              ),
            ],
          ),
        );
      },
    );
  }
}
