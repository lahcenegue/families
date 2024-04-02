import 'package:families/Constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              Positioned(
                top: 0,
                child: Container(
                  width: appSettings.width,
                  height: appSettings.height * 0.32,
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    AppImages.cloud,
                    fit: BoxFit.fill,
                  ),
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
