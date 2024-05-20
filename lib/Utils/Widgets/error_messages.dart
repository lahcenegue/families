import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String errorMessages(BuildContext context, int errorCode) {
  String errorMessage;
  switch (errorCode) {
    case 0:
      {
        errorMessage = AppLocalizations.of(context)!.missing_data;
      }
      break;

    case 1:
      {
        errorMessage = AppLocalizations.of(context)!.record_conflict;
      }
      break;

    case 2:
      {
        errorMessage = AppLocalizations.of(context)!.incomplete_data;
      }
      break;

    case 3:
      {
        errorMessage = AppLocalizations.of(context)!.wrong_credentials;
      }
      break;
    case 4:
      {
        errorMessage = AppLocalizations.of(context)!.token_expired;
      }
      break;
    case 5:
      {
        errorMessage = AppLocalizations.of(context)!.unauthenticated;
      }
      break;
    case 6:
      {
        errorMessage = AppLocalizations.of(context)!.otp_delay;
      }
      break;
    case 7:
      {
        errorMessage = AppLocalizations.of(context)!.wrong_format;
      }
      break;
    case 8:
      {
        errorMessage = AppLocalizations.of(context)!.upload_error;
      }
      break;
    case 10:
      {
        errorMessage = AppLocalizations.of(context)!.agree_terms_conditions;
      }
      break;

    default:
      {
        errorMessage = 'error';
      }
      break;
  }

  return errorMessage;
}
