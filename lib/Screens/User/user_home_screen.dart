// import 'package:families/Utils/Helprs/navigation_service.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../Providers/app_settings_provider.dart';
// import '../../Utils/Constants/app_colors.dart';
// import '../../Utils/Constants/app_images.dart';
// import '../../Utils/Constants/app_styles.dart';
// import '../../Utils/Widgets/custom_banners.dart';
// import '../../Utils/Widgets/family_products.dart';

// class UserHomeScreen extends StatelessWidget {
//   const UserHomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppSettingsProvider>(
//       builder: (context, appsettings, _) {
//         return Scaffold(
//           extendBodyBehindAppBar: true,
//           appBar: AppBar(
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Good morning',
//                   style: AppStyles.styleBold(14, context).copyWith(
//                     color: AppColors.greyTextColors,
//                   ),
//                 ),
//                 Text(
//                   'User Name',
//                   style: AppStyles.styleBold(20, context),
//                 ),
//               ],
//             ),
//             actions: [
//               Image.asset(AppImages.userProfile),
//               const SizedBox(width: 10),
//             ],
//             bottom: PreferredSize(
//               preferredSize: Size(appsettings.width, 60),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 //search
//                 child: TextField(
//                   decoration: const InputDecoration(
//                     hintText: "search",
//                     prefixIcon: Icon(Icons.search),
//                   ),
//                   onSubmitted: (value) {},
//                 ),
//               ),
//             ),
//           ),
//           body: CustomBackground(
//             child: ListView(
//               padding: EdgeInsets.all(appsettings.width * 0.05),
//               children: [
//                 SizedBox(height: appsettings.height * 0.2),
//                 const CustomBanners(),
//                 _customSeparator(
//                   context,
//                   'Product Family',
//                   () {},
//                 ),
//                 Container(
//                   width: appsettings.width,
//                   height: appsettings.height * 0.28,
//                   child: ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 3,
//                     separatorBuilder: (context, index) =>
//                         const SizedBox(width: 24),
//                     itemBuilder: (context, index) {
//                       return FamilyProducts(
//                         onTap: () {
//                           NavigationService.navigateTo(
//                               AppRoutes.productDetails);
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 _customSeparator(
//                   context,
//                   'Previous Requests',
//                   () {},
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _customSeparator(
//     BuildContext context,
//     String title,
//     Function() onPressed,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12),
//       child: Row(
//         children: [
//           Text(
//             title,
//             style: AppStyles.styleRegular(context, 20),
//           ),
//           const Spacer(),
//           TextButton(
//             onPressed: onPressed,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'See All',
//                   style: AppStyles.styleRegular(context, 16),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
