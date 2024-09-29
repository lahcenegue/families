import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../Providers/app_settings_provider.dart';
import '../../Providers/family_manager_provider.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../Utils/Constants/app_size.dart';
import '../../Utils/Constants/app_styles.dart';
import '../../Utils/Widgets/custom_text_field.dart';
import '../../Utils/Widgets/custom_loading_indicator.dart';
import '../../View_models/my_dishs_viewmodel.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditDishScreen extends StatelessWidget {
  final MyDishViewModel dish;

  const EditDishScreen({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Consumer<FamilyManagerProvider>(
      builder: (context, familyManager, _) {
        // Initialize the dish data when the screen is built
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   familyManager.initEditDishData(dish);
        // });

        return Scaffold(
          appBar: _buildAppBar(context),
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.widthSize(25, context),
                  ),
                  child: Form(
                    key: familyManager.editDishFormKey,
                    child: CustomScrollView(
                      slivers: [
                        _buildEditDishForm(context, familyManager),
                      ],
                    ),
                  ),
                ),
                CustomLoadingIndicator(
                  isVisible: familyManager.isApiCallProcess,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'تعديل الطبق',
        style: AppStyles.styleBold(14, context),
      ),
    );
  }

  Widget _buildEditDishForm(
    BuildContext context,
    FamilyManagerProvider familyManager,
  ) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSize.heightSize(20, context)),
          _buildImagePicker(context, familyManager),
          SizedBox(height: AppSize.heightSize(20, context)),
          CustomTextField(
            title: AppLocalizations.of(context)!.dish_name,
            hintText: AppLocalizations.of(context)!.dish_name,
            initialValue: dish.itemName,
            onChanged: (value) {
              familyManager.dishName = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.enter_dish_name;
              }
              return null;
            },
          ),
          SizedBox(height: AppSize.heightSize(20, context)),
          CustomTextField(
            title: AppLocalizations.of(context)!.dish_description,
            hintText: AppLocalizations.of(context)!.dish_description,
            initialValue: dish.description,
            onChanged: (value) {
              familyManager.dishDescription = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.enter_dish_description;
              }
              return null;
            },
          ),
          SizedBox(height: AppSize.heightSize(20, context)),
          CustomTextField(
            title: AppLocalizations.of(context)!.price,
            hintText: AppLocalizations.of(context)!.price,
            initialValue: dish.price.toString(),
            onChanged: (value) {
              familyManager.dishPrice = double.tryParse(value);
            },
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.enter_price;
              }
              return null;
            },
          ),
          SizedBox(height: AppSize.heightSize(20, context)),
          CustomTextField(
            title: AppLocalizations.of(context)!.time,
            hintText: '15',
            initialValue: dish.preparationTime.toString(),
            onChanged: (value) {
              familyManager.preparationTime = int.tryParse(value);
            },
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.enter_preparation_time;
              }
              return null;
            },
          ),
          SizedBox(height: AppSize.heightSize(30, context)),
          ElevatedButton(
            onPressed: () async {
              await familyManager.editDishFunction(dish.itemId!);
            },
            child: Text(
              'حفظ التغييرات',
              style: AppStyles.styleBold(14, context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker(
      BuildContext context, FamilyManagerProvider familyManager) {
    return GestureDetector(
      onTap: () async {
        await familyManager.pickDishImage();
      },
      child: Container(
        width: AppSize.width(context),
        height: AppSize.heightSize(150, context),
        decoration: BoxDecoration(
          color: Provider.of<AppSettingsProvider>(context).isDark
              ? AppColors.darkContainerBackground
              : const Color(0xFFf5f5f5),
          borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
        ),
        child: familyManager.dishImage != null
            ? Image.file(
                familyManager.dishImage!,
                fit: BoxFit.cover,
              )
            : (dish.firstImage != null
                ? CachedNetworkImage(
                    imageUrl: dish.firstImage!,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        size: AppSize.iconSize(28, context),
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(height: AppSize.heightSize(15, context)),
                      Text(
                        'تغيير الصورة',
                        style: AppStyles.styleBold(12, context),
                      )
                    ],
                  )),
      ),
    );
  }
}
