import 'package:flutter/material.dart';

import '../Constants/app_colors.dart';

class DotIndicator extends StatelessWidget {
  final bool isActive;
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10,
      width: isActive ? 40 : 10,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : const Color(0xFFced3d8),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
