import 'package:families/Utils/Constants/app_size.dart';
import 'package:flutter/material.dart';

import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: AppSize.width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: AppSize.widthSize(180, context),
              height: AppSize.widthSize(200, context),
              child: Image.asset(
                AppImages.logo,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: AppSize.heightSize(20, context),
            ),
            Text(
              'مأكول',
              style: AppStyles.styleExtraBold(52, context),
            ),
          ],
        ),
      ),
    );
  }
}
