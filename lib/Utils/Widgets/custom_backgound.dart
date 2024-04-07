import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Constants/app_images.dart';
import '../Constants/app_size.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  const CustomBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.height(context),
      width: AppSize.width(context),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              width: AppSize.width(context),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: SvgPicture.asset(
                  AppImages.cloud,
                  fit: BoxFit.fill,
                ),
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
  }
}
