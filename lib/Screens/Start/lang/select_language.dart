// import 'package:families/Providers/app_settings_provider.dart';
// import 'package:families/Utils/Constants/app_size.dart';
// import 'package:families/Utils/Widgets/custom_backgound.dart';
// import 'package:families/Utils/Helprs/navigation_service.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import '../../../Utils/Constants/app_colors.dart';
// import '../../../Utils/Constants/app_images.dart';
// import '../../../Utils/Constants/app_styles.dart';

// class SelectLanguage extends StatelessWidget {
//   const SelectLanguage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppSettingsProvider>(
//       builder: (context, appSettings, _) {
//         return Scaffold(
//           body: CustomBackground(
//             child: Padding(
//               padding: EdgeInsets.all(AppSize.widthSize(24, context)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.g_translate,
//                     color: Colors.white,
//                     size: AppSize.iconSize(100, context),
//                   ),
//                   SizedBox(
//                     height: AppSize.heightSize(18, context),
//                   ),
//                   Text(
//                     AppLocalizations.of(context)!.choose_lang,
//                     style: AppStyles.styleBold(22, context),
//                   ),
//                   Text(
//                     AppLocalizations.of(context)!.select_lang,
//                     style: AppStyles.styleRegular(context, 14),
//                   ),
//                   SizedBox(height: AppSize.heightSize(80, context)),
//                   Row(
//                     children: [
//                       Container(
//                         width: AppSize.widthSize(68, context),
//                         height: AppSize.widthSize(68, context),
//                         padding: EdgeInsets.all(AppSize.widthSize(15, context)),
//                         decoration: BoxDecoration(
//                           color: AppColors.fillColor,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Image.asset(
//                           AppImages.arabicFlag,
//                         ),
//                       ),
//                       SizedBox(width: AppSize.widthSize(10, context)),
//                       TextButton(
//                         onPressed: () {
//                           NavigationService.navigateTo(
//                               AppRoutes.onBordingScreen);
//                           appSettings.toggleLocale(const Locale('ar'));
//                         },
//                         child: Text(
//                           AppLocalizations.of(context)!.arabic,
//                           style: AppStyles.styleMedium(context, 28),
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(height: AppSize.heightSize(20, context)),
//                   const Divider(),
//                   SizedBox(height: AppSize.heightSize(20, context)),
//                   Row(
//                     children: [
//                       Container(
//                         width: AppSize.widthSize(68, context),
//                         height: AppSize.widthSize(68, context),
//                         padding: EdgeInsets.all(AppSize.widthSize(15, context)),
//                         decoration: BoxDecoration(
//                           color: AppColors.fillColor,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Image.asset(
//                           AppImages.englishFlag,
//                         ),
//                       ),
//                       SizedBox(width: AppSize.widthSize(10, context)),
//                       TextButton(
//                         onPressed: () {
//                           NavigationService.navigateTo(
//                               AppRoutes.onBordingScreen);
//                           appSettings.toggleLocale(const Locale('en'));
//                         },
//                         child: Text(
//                           AppLocalizations.of(context)!.english,
//                           style: AppStyles.styleMedium(context, 28),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
