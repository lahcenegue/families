import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../../Providers/login_register_manager.dart';
import '../../../Providers/app_settings_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Helprs/navigation_service.dart';
import '../../../Utils/Widgets/costum_snackbar.dart';
import '../../../Utils/Widgets/custom_loading_indicator.dart';
import '../../../Utils/Widgets/custom_text_field.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FamilyRegisterScreen extends StatelessWidget {
  const FamilyRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginAndRegisterManager>(
      builder: (context, registerManager, _) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.widthSize(25, context),
                  ),
                  child: Form(
                    key: registerManager.registerFormKey,
                    child: CustomScrollView(
                      slivers: [
                        _buildProfileImage(context, registerManager),
                        _buildRegisterForm(context, registerManager),
                        _buildFooter(context, registerManager),
                      ],
                    ),
                  ),
                ),
                CustomLoadingIndicator(
                  isVisible: registerManager.isApiCallProcess,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileImage(
    BuildContext context,
    LoginAndRegisterManager registerManager,
  ) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(height: AppSize.widthSize(50, context)),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryColor,
                width: 3,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ClipOval(
                    child: registerManager.storeImage != null
                        ? Image.file(
                            registerManager.storeImage!,
                            width: AppSize.widthSize(100, context),
                            height: AppSize.widthSize(100, context),
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            AppImages.storeProfilImage,
                            width: AppSize.widthSize(100, context),
                            height: AppSize.widthSize(100, context),
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: AppSize.widthSize(100, context),
                    height: AppSize.widthSize(100, context),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppColors.primaryColor.withOpacity(0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                        onPressed: () {
                          registerManager.pickProfileImage();
                        },
                        icon: Icon(
                          Icons.photo_camera,
                          color: AppColors.primaryColor,
                          size: AppSize.iconSize(28, context),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterForm(
      BuildContext context, LoginAndRegisterManager registerManager) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSize.heightSize(50, context)),
          Text(
            AppLocalizations.of(context)!.sign_up,
            style: AppStyles.styleBold(24, context),
          ),
          Text(
            AppLocalizations.of(context)!.please_signup,
            textAlign: TextAlign.center,
            style: AppStyles.styleRegular(16, context),
          ),
          SizedBox(height: AppSize.heightSize(30, context)),
          _buildTextFields(context, registerManager),
          _buildCheckbox(context, registerManager),
        ],
      ),
    );
  }

  Widget _buildTextFields(
      BuildContext context, LoginAndRegisterManager registerManager) {
    return Column(
      children: [
        CustomTextField(
          title: AppLocalizations.of(context)!.store_name,
          hintText: AppLocalizations.of(context)!.store_name,
          onChanged: (value) =>
              registerManager.registerRequestModel.storeName = value,
          validator: (value) => value?.isEmpty ?? true
              ? AppLocalizations.of(context)!.storeName_entryPrompt
              : null,
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: AppSize.heightSize(20, context)),
        CustomTextField(
          title: AppLocalizations.of(context)!.phone,
          hintText: '050 505 505',
          onChanged: (value) => registerManager
              .registerRequestModel.phoneNumber = int.tryParse(value),
          validator: (value) => value?.isEmpty ?? true
              ? AppLocalizations.of(context)!.phone_entryPrompt
              : null,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: AppSize.heightSize(20, context)),
        CustomTextField(
          title: 'العنوان',
          hintText: 'العنوان',
          onChanged: (value) =>
              registerManager.registerRequestModel.location = value,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please select a location' : null,
        ),
        SizedBox(height: AppSize.heightSize(20, context)),
        _buildCategoryField(context, registerManager),
        SizedBox(height: AppSize.heightSize(20, context)),
        _buildCertificateField(context, registerManager),
        SizedBox(height: AppSize.heightSize(20, context)),
        _buildDescriptionField(context, registerManager),
        SizedBox(height: AppSize.heightSize(20, context)),
        CustomTextField(
          title: AppLocalizations.of(context)!.password,
          hintText: '*********',
          onChanged: (value) {
            registerManager.registerRequestModel.password = value;
            registerManager.firstPasword(value);
          },
          validator: (value) => value?.isEmpty ?? true
              ? AppLocalizations.of(context)!.password_entryPrompt
              : null,
          suffixIcon: registerManager.isVisible
              ? Icons.visibility_off
              : Icons.visibility,
          suffixChanged: () => registerManager.toggleVisibility(fieldIndex: 1),
          keyboardType: TextInputType.visiblePassword,
          obscureText: !registerManager.isVisible,
        ),
        SizedBox(height: AppSize.heightSize(20, context)),
        CustomTextField(
          title: AppLocalizations.of(context)!.retype_password,
          hintText: '*********',
          onChanged: (_) {},
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return AppLocalizations.of(context)!.password_entryPrompt;
            }
            if (value != registerManager.checkPassrowd) {
              return AppLocalizations.of(context)!.password_mismatch;
            }
            return null;
          },
          suffixIcon: registerManager.isVisible2
              ? Icons.visibility_off
              : Icons.visibility,
          suffixChanged: () => registerManager.toggleVisibility(fieldIndex: 2),
          keyboardType: TextInputType.visiblePassword,
          obscureText: !registerManager.isVisible2,
        ),
      ],
    );
  }

  Widget _buildCategoryField(
      BuildContext context, LoginAndRegisterManager registerManager) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'تصنيف المتجر',
            style: AppStyles.styleRegular(13, context),
          ),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: registerManager.storeClassification,
          items: [
            'حلويات',
            'مشروبات',
            'مأكولات شعبية',
            'مأكولات عربية ',
            'مأكولات عالمية',
            'بوفيهات'
          ]
              .map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child:
                        Text(value, style: AppStyles.styleRegular(13, context)),
                  ))
              .toList(),
          onChanged: (value) {
            registerManager.registerRequestModel.category = value;
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء اختيار التصنيف';
            }
            return null;
          },
          dropdownColor: Provider.of<AppSettingsProvider>(context).isDark
              ? Colors.grey[800]
              : Colors.white,
          style: AppStyles.styleRegular(13, context),
        ),
      ],
    );
  }

  Widget _buildCertificateField(
      BuildContext context, LoginAndRegisterManager registerManager) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'رفع صورة شهادة الأسر المنتجة',
            style: AppStyles.styleRegular(13, context),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: AppSize.width(context),
          height: AppSize.heightSize(150, context),
          decoration: BoxDecoration(
            color: Provider.of<AppSettingsProvider>(context).isDark
                ? AppColors.darkContainerBackground
                : Colors.white,
            borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
            border: Border.all(color: Colors.grey),
          ),
          child: registerManager.medicalCertificate != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSize.widthSize(20, context)),
                      child: Image.file(
                        registerManager.medicalCertificate!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () =>
                              _showCertificateDialog(context, registerManager),
                          borderRadius: BorderRadius.circular(
                              AppSize.widthSize(20, context)),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: IconButton(
                    onPressed: () => registerManager.pickMedicalCertificate(),
                    icon: Icon(
                      Icons.upload_file_rounded,
                      color: AppColors.primaryColor,
                      size: AppSize.iconSize(30, context),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField(
      BuildContext context, LoginAndRegisterManager registerManager) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'نبذة عن المتجر',
            style: AppStyles.styleRegular(13, context),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'نبذة عن المتجر',
            alignLabelWithHint: true,
            hintStyle: AppStyles.styleRegular(13, context),
          ),
          style: AppStyles.styleRegular(13, context),
          onChanged: (value) {
            registerManager.registerRequestModel.description = value;
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء إدخال الوصف';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _showCertificateDialog(
      BuildContext context, LoginAndRegisterManager registerManager) {
    if (registerManager.medicalCertificate != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: PhotoView(
                    imageProvider:
                        FileImage(registerManager.medicalCertificate!),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    initialScale: PhotoViewComputedScale.contained,
                    backgroundDecoration:
                        const BoxDecoration(color: Colors.transparent),
                  ),
                ),
                Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      onPressed: () {
                        registerManager.removeMedicalCertificate();
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: AppSize.iconSize(30, context),
                      ),
                    )),
              ],
            ),
          );
        },
      );
    }
  }

  Widget _buildCheckbox(
      BuildContext context, LoginAndRegisterManager registerManager) {
    return Row(
      children: [
        Checkbox(
          value: registerManager.isAgree,
          onChanged: (value) => registerManager.toggleIsAgree(value!),
        ),
        SizedBox(
          width: AppSize.widthSize(240, context),
          child: Text(
            AppLocalizations.of(context)!.agree_terms_conditions,
            style: AppStyles.styleRegular(12, context),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(
      BuildContext context, LoginAndRegisterManager registerManager) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        children: [
          Expanded(child: SizedBox(height: AppSize.heightSize(50, context))),
          ElevatedButton(
            onPressed: () async {
              int? result = await registerManager.register();
              if (!context.mounted) return;
              safeShowErrorMessage(context, result);
            },
            child: Text(AppLocalizations.of(context)!.sign_up),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.have_account,
                style: AppStyles.styleMedium(13, context),
              ),
              TextButton(
                onPressed: () => NavigationService.goBack(),
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: AppStyles.styleMedium(13, context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.heightSize(50, context)),
        ],
      ),
    );
  }
}

// class FamilyRegisterScreen extends StatelessWidget {
//   const FamilyRegisterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<LoginAndRegisterManager>(
//       builder: (context, registerManager, _) {
//         return Scaffold(
//           body: SafeArea(
//             child: Stack(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: AppSize.widthSize(25, context),
//                   ),
//                   child: Form(
//                     key: registerManager.registerFormKey,
//                     child: CustomScrollView(
//                       slivers: [
//                         _buildProfileImage(context, registerManager),
//                         _buildRegisterForm(context, registerManager),
//                         _buildCheckbox(context, registerManager),
//                         _buildFooter(context, registerManager),
//                       ],
//                     ),
//                   ),
//                 ),
//                 CustomLoadingIndicator(
//                   isVisible: registerManager.isApiCallProcess,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildProfileImage(
//     BuildContext context,
//     LoginAndRegisterManager registerManager,
//   ) {
//     return SliverToBoxAdapter(
//       child: Column(
//         children: [
//           SizedBox(height: AppSize.widthSize(50, context)),
//           Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: AppColors.primaryColor,
//                 width: 3,
//               ),
//             ),
//             child: Stack(
//               children: [
//                 Align(
//                   alignment: Alignment.center,
//                   child: ClipOval(
//                     child: registerManager.storeImage != null
//                         ? Image.file(
//                             registerManager.storeImage!,
//                             width: AppSize.widthSize(100, context),
//                             height: AppSize.widthSize(100, context),
//                             fit: BoxFit.contain,
//                           )
//                         : Image.asset(
//                             AppImages.storeProfilImage,
//                             width: AppSize.widthSize(100, context),
//                             height: AppSize.widthSize(100, context),
//                             fit: BoxFit.contain,
//                           ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Container(
//                     width: AppSize.widthSize(100, context),
//                     height: AppSize.widthSize(100, context),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: LinearGradient(
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                         colors: [
//                           AppColors.primaryColor.withOpacity(0.5),
//                           Colors.transparent,
//                         ],
//                       ),
//                     ),
//                     child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: IconButton(
//                         onPressed: () {
//                           registerManager.pickProfileImage();
//                         },
//                         icon: Icon(
//                           Icons.photo_camera,
//                           color: AppColors.primaryColor,
//                           size: AppSize.iconSize(28, context),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRegisterForm(
//     BuildContext context,
//     LoginAndRegisterManager registerManager,
//   ) {
//     return SliverToBoxAdapter(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: AppSize.heightSize(50, context)),
//           Text(
//             AppLocalizations.of(context)!.sign_up,
//             style: AppStyles.styleBold(24, context),
//           ),
//           Text(
//             AppLocalizations.of(context)!.please_signup,
//             textAlign: TextAlign.center,
//             style: AppStyles.styleRegular(16, context),
//           ),
//           SizedBox(height: AppSize.heightSize(30, context)),
//           _buildStoreNameField(context, registerManager),
//           SizedBox(height: AppSize.heightSize(20, context)),
//           _buildPhoneField(context, registerManager),
//           SizedBox(height: AppSize.heightSize(20, context)),
//           _buildLocationField(context, registerManager),
//           SizedBox(height: AppSize.heightSize(20, context)),
//           _buildCategoryField(context, registerManager),
//           SizedBox(height: AppSize.heightSize(20, context)),
//           _buildCertificateField(context, registerManager),
//           SizedBox(height: AppSize.heightSize(20, context)),
//           _buildDescriptionField(context, registerManager),
//           SizedBox(height: AppSize.heightSize(20, context)),
//           _buildPasswordField(context, registerManager),
//           SizedBox(height: AppSize.heightSize(20, context)),
//           _buildRetypePasswordField(context, registerManager),
//         ],
//       ),
//     );
//   }

//   Widget _buildStoreNameField(
//       BuildContext context, LoginAndRegisterManager registerManager) {
//     return CustomTextField(
//       title: AppLocalizations.of(context)!.store_name,
//       hintText: AppLocalizations.of(context)!.store_name,
//       onChanged: (value) {
//         registerManager.registerRequestModel.storeName = value;
//       },
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return AppLocalizations.of(context)!.storeName_entryPrompt;
//         }
//         return null;
//       },
//       keyboardType: TextInputType.text,
//     );
//   }

//   Widget _buildPhoneField(
//       BuildContext context, LoginAndRegisterManager registerManager) {
//     return CustomTextField(
//       title: AppLocalizations.of(context)!.phone,
//       hintText: '050 505 505',
//       onChanged: (value) {
//         registerManager.registerRequestModel.phoneNumber = int.parse(value);
//       },
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return AppLocalizations.of(context)!.phone_entryPrompt;
//         }
//         return null;
//       },
//       keyboardType: TextInputType.phone,
//     );
//   }

//   Widget _buildLocationField(
//       BuildContext context, LoginAndRegisterManager registerManager) {
//     return CustomTextField(
//       title: 'العنوان',
//       hintText: 'العنوان',
//       onChanged: (value) {
//         registerManager.registerRequestModel.location = value;
//       },
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please select a location';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildCategoryField(
//       BuildContext context, LoginAndRegisterManager registerManager) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Text(
//             'تصنيف المتجر',
//             style: AppStyles.styleRegular(13, context)
//                 .copyWith(color: const Color(0xFF32343E)),
//           ),
//         ),
//         const SizedBox(height: 5),
//         DropdownButtonFormField<String>(
//           value: registerManager.storeClassification,
//           items: [
//             'حلويات',
//             'مشروبات',
//             'مأكولات شعبية',
//             'مأكولات عربية ',
//             'مأكولات عالمية',
//             'بوفيهات'
//           ]
//               .map((String value) => DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   ))
//               .toList(),
//           onChanged: (value) {
//             registerManager.registerRequestModel.category = value;
//           },
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'الرجاء اختيار التصنيف';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildCertificateField(
//       BuildContext context, LoginAndRegisterManager registerManager) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Text(
//             'رفع صورة شهادة الأسر المنتجة',
//             style: AppStyles.styleRegular(13, context)
//                 .copyWith(color: const Color(0xFF32343E)),
//           ),
//         ),
//         const SizedBox(height: 5),
//         Container(
//           width: AppSize.width(context),
//           decoration: BoxDecoration(
//             color: AppColors.fieldFillColor,
//             borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
//           ),
//           child: registerManager.medicalCertificate != null
//               ? InkWell(
//                   onTap: registerManager.pickMedicalCertificate,
//                   child: Image.file(
//                     registerManager.medicalCertificate!,
//                     width: AppSize.widthSize(100, context),
//                     height: AppSize.widthSize(100, context),
//                     fit: BoxFit.contain,
//                   ),
//                 )
//               : IconButton(
//                   onPressed: registerManager.pickMedicalCertificate,
//                   icon: Icon(
//                     Icons.upload_file_rounded,
//                     color: AppColors.primaryColor,
//                     size: AppSize.iconSize(24, context),
//                   )),
//         ),
//       ],
//     );
//   }

//   Widget _buildDescriptionField(
//       BuildContext context, LoginAndRegisterManager registerManager) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Text(
//             'نبذة عن المتجر',
//             style: AppStyles.styleRegular(13, context)
//                 .copyWith(color: const Color(0xFF32343E)),
//           ),
//         ),
//         const SizedBox(height: 5),
//         TextFormField(
//           maxLines: 5,
//           decoration: const InputDecoration(
//             hintText: 'نبذة عن المتجر',
//             alignLabelWithHint: true,
//           ),
//           onChanged: (value) {
//             registerManager.registerRequestModel.description = value;
//           },
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter a description';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildPasswordField(
//       BuildContext context, LoginAndRegisterManager registerManager) {
//     return CustomTextField(
//       title: AppLocalizations.of(context)!.password,
//       hintText: '*********',
//       onChanged: (value) {
//         registerManager.registerRequestModel.password = value;
//         registerManager.firstPasword(value);
//       },
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return AppLocalizations.of(context)!.password_entryPrompt;
//         }
//         return null;
//       },
//       suffixIcon:
//           registerManager.isVisible ? Icons.visibility_off : Icons.visibility,
//       suffixChanged: () {
//         registerManager.toggleVisibility(fieldIndex: 1);
//       },
//       keyboardType: TextInputType.visiblePassword,
//       obscureText: !registerManager.isVisible,
//     );
//   }

//   Widget _buildRetypePasswordField(
//       BuildContext context, LoginAndRegisterManager registerManager) {
//     return CustomTextField(
//       title: AppLocalizations.of(context)!.retype_password,
//       hintText: '*********',
//       onChanged: (value) {},
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return AppLocalizations.of(context)!.password_entryPrompt;
//         }
//         if (value != registerManager.checkPassrowd) {
//           return AppLocalizations.of(context)!.password_mismatch;
//         }
//         return null;
//       },
//       suffixIcon:
//           registerManager.isVisible2 ? Icons.visibility_off : Icons.visibility,
//       suffixChanged: () {
//         registerManager.toggleVisibility(fieldIndex: 2);
//       },
//       keyboardType: TextInputType.visiblePassword,
//       obscureText: !registerManager.isVisible2,
//     );
//   }




// }
