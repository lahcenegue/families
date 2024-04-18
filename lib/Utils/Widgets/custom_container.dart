// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../Providers/app_settings_provider.dart';
// import '../Constants/app_colors.dart';
// import '../Constants/app_size.dart';

// class CustomContainer extends StatelessWidget {
//   final Widget child;
//   const CustomContainer({
//     super.key,
//     required this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppSettingsProvider>(
//       builder: (context, appSettings, _) {
//         return Container(
//           width: AppSize.width(context),
//           margin: EdgeInsets.symmetric(horizontal: appSettings.width * 0.03),
//           padding: EdgeInsets.symmetric(
//             vertical: appSettings.width * 0.02,
//             horizontal: appSettings.width * 0.05,
//           ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(appSettings.width * 0.05),
//             color: AppColors.fillColor,
//           ),
//           child: child,
//         );
//       },
//     );
//   }
// }
