import 'package:flutter/material.dart';
import 'error_messages.dart';

void errorMessagesShow(BuildContext context, int? errorCode) {
  if (errorCode != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessages(context, errorCode))),
    );
  }
}
