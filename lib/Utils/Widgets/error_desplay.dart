import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  final String? errorMessage;

  const ErrorDisplay({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    if (errorMessage == null) return SizedBox.shrink();
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          errorMessage!,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
