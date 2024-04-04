import 'package:families/Constants/app_colors.dart';
import 'package:flutter/material.dart';

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
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
