// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class ResetPasswordScreen extends StatelessWidget {
//   const ResetPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer2<AppSettingsProvider, LoginAndRegisterManager>(
//       builder: (context, appSettings, resteManager, _) {
//         return Scaffold(
//           body: Stack(
//             children: [
//               Form(
//                 key: resteManager.resetFormKey,
//                 child: ListView(
//                   padding: EdgeInsets.all(appSettings.width * 0.08),
//                   children: [
//                     SizedBox(height: appSettings.width * 0.10),
//                     Container(
//                       padding: EdgeInsets.all(appSettings.width * 0.08),
//                       width: appSettings.width * 0.1,
//                       height: appSettings.width * 0.4,
//                       child: Image.asset(
//                         appSettings.isDark
//                             ? AppImages.logoDark
//                             : AppImages.logoLight,
//                         width: appSettings.width * 0.1,
//                       ),
//                     ),
//                     Text(
//                       AppLocalizations.of(context)!.rest_password,
//                       style: TextStyle(
//                         fontSize: appSettings.width * 0.06,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),

//                     SizedBox(height: appSettings.width * 0.07),

//                     // password 1
//                     CustomTextField(
//                       controller: resteManager.passwordController,
//                       onChanged: (value) {
//                         resteManager.resetRequestModel.password = value;
//                       },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return AppLocalizations.of(context)!
//                               .passwordEntryPrompt;
//                         }
//                         return null;
//                       },
//                       prefixIcon: Icons.key,
//                       suffixIcon: resteManager.isVisible == true
//                           ? Icons.visibility_off
//                           : Icons.visibility,
//                       suffixChanged: () {
//                         resteManager.togglePasswordVisibility();
//                       },
//                       keyboardType: TextInputType.visiblePassword,
//                       hintText: AppLocalizations.of(context)!.password,
//                       obscureText: !resteManager.isVisible,
//                     ),

//                     SizedBox(height: appSettings.width * 0.10),

//                     // button
//                     ElevatedButton(
//                       onPressed: () async {
//                         await resteManager.restetPassword().then(
//                               (value) => _handleResetResult(context, value),
//                             );
//                       },
//                       child: Text(
//                         AppLocalizations.of(context)!.rest_password,
//                       ),
//                     ),

//                     SizedBox(height: appSettings.width * 0.05),
//                   ],
//                 ),
//               ),
//               Visibility(
//                 visible: resteManager.isApiCallProcess,
//                 child: Stack(
//                   children: [
//                     ModalBarrier(
//                       color: Colors.white.withOpacity(0.6),
//                       dismissible: true,
//                     ),
//                     const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _handleResetResult(BuildContext context, String? result) {
//     if (result == 'error') {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content: Text(AppLocalizations.of(context)!.registrationError)),
//       );
//     }
//   }
// }
