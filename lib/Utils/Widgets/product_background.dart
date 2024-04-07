import 'package:families/Providers/app_settings_provider.dart';
import 'package:families/Utils/Constants/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_images.dart';

class ProductBackground extends StatelessWidget {
  final Widget child;
  const ProductBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, appSettings, _) {
        return SizedBox(
          width: AppSize.width(context),
          height: AppSize.height(context),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    width: AppSize.width(context),
                    height: appSettings.height * 0.82,
                    decoration: BoxDecoration(
                      color: AppColors.fillColor,
                    ),
                    child: child,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: appSettings.width * 0.55,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            AppImages.salade,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            AppImages.plat,
                            width: appSettings.width * 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, size.height * 0.1);

    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height * 0.1);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
