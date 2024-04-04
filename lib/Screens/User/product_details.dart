import 'package:families/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/app_settings_provider.dart';
import '../../Widgets/custom_backgound.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, appSettings, _) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(),
          body: CustomBackground(
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      width: appSettings.width,
                      height: appSettings.height * 0.9,
                      decoration: BoxDecoration(
                        color: AppColors.fillColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
