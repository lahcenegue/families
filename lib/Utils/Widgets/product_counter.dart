import 'package:flutter/material.dart';

import '../Constants/app_styles.dart';

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
          style: AppStyles.styleBold(16, context),
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
