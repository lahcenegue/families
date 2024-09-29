import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String appErrorMessages(int? code, AppLocalizations appLocalizations) {
  if (code == null) return '';

  switch (code) {
    case 0:
      return appLocalizations.missing_data;
    case 1:
      return appLocalizations.record_conflict;
    case 2:
      return appLocalizations.incomplete_data;
    case 3:
      return appLocalizations.wrong_credentials;
    case 4:
      return appLocalizations.token_expired;
    case 5:
      return appLocalizations.unauthenticated;
    case 6:
      return appLocalizations.otp_delay;
    case 7:
      return appLocalizations.wrong_format;
    case 8:
      return appLocalizations.upload_error;
    case 10:
      return appLocalizations.agree_terms_conditions;
    case 11:
      return 'تمت إضافة الطبق إلى السلة بنجاح!';
    case 12:
      return 'فشل في إضافة الطبق إلى السلة.';
    case 13:
      return 'حدث خطأ أثناء إضافة الطبق إلى السلة.';
    default:
      return 'error';
  }
}
