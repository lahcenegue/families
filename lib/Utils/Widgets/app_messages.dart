import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String appMessages(BuildContext context, int code) {
  String appMessage;
  switch (code) {
    case 0:
      {
        appMessage = AppLocalizations.of(context)!.missing_data;
      }
      break;

    case 1:
      {
        appMessage = AppLocalizations.of(context)!.record_conflict;
      }
      break;

    case 2:
      {
        appMessage = AppLocalizations.of(context)!.incomplete_data;
      }
      break;

    case 3:
      {
        appMessage = AppLocalizations.of(context)!.wrong_credentials;
      }
      break;
    case 4:
      {
        appMessage = AppLocalizations.of(context)!.token_expired;
      }
      break;
    case 5:
      {
        appMessage = AppLocalizations.of(context)!.unauthenticated;
      }
      break;
    case 6:
      {
        appMessage = AppLocalizations.of(context)!.otp_delay;
      }
      break;
    case 7:
      {
        appMessage = AppLocalizations.of(context)!.wrong_format;
      }
      break;
    case 8:
      {
        appMessage = AppLocalizations.of(context)!.upload_error;
      }
      break;
    case 10:
      {
        appMessage = AppLocalizations.of(context)!.agree_terms_conditions;
      }
      break;
    case 11:
      {
        appMessage = 'تمت إضافة الطبق إلى السلة بنجاح!';
      }
      break;
    case 12:
      {
        appMessage = 'فشل في إضافة الطبق إلى السلة.';
      }
      break;
    case 13:
      {
        appMessage = 'حدث خطأ أثناء إضافة الطبق إلى السلة.';
      }
      break;

    default:
      {
        appMessage = 'error';
      }
      break;
  }

  return appMessage;
}
