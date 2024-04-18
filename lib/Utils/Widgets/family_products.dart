// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../Providers/app_settings_provider.dart';
// import '../Constants/app_colors.dart';
// import '../Constants/app_images.dart';
// import '../Constants/app_styles.dart';

// class FamilyProducts extends StatelessWidget {
//   final Function()? onTap;
//   const FamilyProducts({
//     super.key,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppSettingsProvider>(
//       builder: (context, appSettings, _) {
//         return InkWell(
//           onTap: onTap,
//           child: SizedBox(
//             width: appSettings.width * 0.45,
//             child: Stack(
//               children: [
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     width: double.infinity,
//                     height: appSettings.height * 0.2,
//                     padding: EdgeInsets.only(
//                       top: appSettings.height * 0.09,
//                       left: 12,
//                       right: 12,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.fillColor,
//                       borderRadius: BorderRadius.circular(24),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Name',
//                           style: AppStyles.styleBold(18, context),
//                         ),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.star_rate_sharp,
//                               color: Colors.yellow,
//                             ),
//                             Icon(
//                               Icons.star_rate_sharp,
//                               color: Colors.yellow,
//                             ),
//                             const Spacer(),
//                             Text(
//                               '20 Minutes',
//                               style:
//                                   AppStyles.styleRegular(context, 14).copyWith(
//                                 color: AppColors.greyTextColors,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: Container(
//                     width: appSettings.width * 0.35,
//                     height: appSettings.height * 0.15,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       // color: Colors.white,
//                       image: DecorationImage(
//                           image: AssetImage(
//                         AppImages.pizza,
//                       )),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
