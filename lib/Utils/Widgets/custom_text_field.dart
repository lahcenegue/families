import 'package:flutter/material.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_styles.dart';

class CustomTextField extends StatelessWidget {
  final IconData? suffixIcon;
  final Function()? suffixChanged;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final bool? obscureText;

  const CustomTextField({
    required this.title,
    required this.hintText,
    required this.onChanged,
    this.controller,
    this.suffixIcon,
    this.suffixChanged,
    this.keyboardType,
    this.validator,
    this.obscureText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            title!,
            style: AppStyles.styleRegular(11, context),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText == null ? false : obscureText!,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            hintText: hintText,
            suffixIcon: suffixIcon == null
                ? const SizedBox()
                : IconButton(
                    onPressed: suffixChanged,
                    icon: Icon(
                      suffixIcon,
                      color: AppColors.hintColor,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
