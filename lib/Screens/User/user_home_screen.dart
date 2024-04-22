import 'package:flutter/material.dart';

import '../../Utils/Constants/app_colors.dart';
import '../../Utils/Constants/app_styles.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning',
              style: AppStyles.styleBold(14, context).copyWith(
                color: AppColors.greyTextColors,
              ),
            ),
            Text(
              'User Name',
              style: AppStyles.styleBold(20, context),
            ),
          ],
        ),
      ),
    );
  }
}
