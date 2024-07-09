import 'package:flutter/material.dart';
import 'app_messages.dart';

void customSnackBar(
  BuildContext context,
  int? code,
) {
  if (code != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(appMessages(context, code)),
      ),
    );
  }
}
