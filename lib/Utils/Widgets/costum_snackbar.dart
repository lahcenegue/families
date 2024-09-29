// import 'package:flutter/material.dart';
// import 'app_messages.dart';

// void customSnackBar(
//   BuildContext context,
//   int? code,
// ) {
//   if (code != null) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(appMessages(context, code)),
//       ),
//     );
//   }
// }

import 'package:families/Utils/Widgets/app_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void safeShowErrorMessage(BuildContext context, int? code) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  final appLocalizations = AppLocalizations.of(context)!;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (context.mounted) {
      String message = appErrorMessages(code, appLocalizations);
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
    }
  });
}
