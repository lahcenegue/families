import 'package:flutter/material.dart';

languageName(String val) {
  switch (val) {
    case 'en':
      return const Text('English');
    case 'ar':
      return const Text('العربية');
  }
}
