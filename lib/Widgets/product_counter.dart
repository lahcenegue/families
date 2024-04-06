import 'package:families/Constants/app_styles.dart';
import 'package:flutter/material.dart';

class ProductCounter extends StatelessWidget {
  const ProductCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.remove_circle,
              color: Colors.white,
            )),
        Text(
          '1',
          style: AppStyles.styleBold(context, 16),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add_circle,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
