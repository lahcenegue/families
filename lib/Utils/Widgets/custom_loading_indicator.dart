import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final bool isVisible;
  const CustomLoadingIndicator({
    super.key,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Stack(
        children: [
          ModalBarrier(
            color: Colors.black.withOpacity(0.6),
            dismissible: true,
          ),
          const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
