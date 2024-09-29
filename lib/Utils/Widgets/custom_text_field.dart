import 'package:flutter/material.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_styles.dart';

class CustomTextField extends StatelessWidget {
  final IconData? suffixIcon;
  final VoidCallback? suffixChanged;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final bool obscureText;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  const CustomTextField({
    required this.title,
    required this.hintText,
    required this.onChanged,
    this.controller,
    this.suffixIcon,
    this.suffixChanged,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.titleStyle,
    this.textStyle,
    this.hintStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            title!,
            style: titleStyle ?? AppStyles.styleBold(11, context),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: textStyle ??
              AppStyles.styleMedium(14, context).copyWith(
                color: isDark ? Colors.white : Colors.black,
              ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            hintText: hintText,
            hintStyle: hintStyle ??
                AppStyles.styleRegular(14, context).copyWith(
                  color: AppColors.hintColor,
                ),
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: suffixChanged,
                    icon: Icon(
                      suffixIcon,
                      color: isDark ? Colors.white70 : AppColors.hintColor,
                    ),
                  )
                : null,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
