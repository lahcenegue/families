import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/family_manager_provider.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../Utils/Constants/app_size.dart';
import '../../Utils/Constants/app_styles.dart';
import '../../Utils/Widgets/custom_text_field.dart';
import '../../Utils/Widgets/custom_loading_indicator.dart';

class AddNewDish extends StatelessWidget {
  const AddNewDish({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FamilyManagerProvider>(
      builder: (context, familyManager, _) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.widthSize(25, context)),
                  child: Form(
                    key: familyManager.addDishFormKey,
                    child: CustomScrollView(
                      slivers: [
                        _buildAddDishForm(context, familyManager),
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
        'اضافة طبق',
        style: AppStyles.styleBold(14, context),
      ),
    );
  }

  Widget _buildAddDishForm(
      BuildContext context, FamilyManagerProvider familyManager) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSize.heightSize(20, context)),
          GestureDetector(
            onTap: () async {
              await familyManager.pickPDishImage();
            },
            child: Container(
              width: AppSize.width(context),
              height: AppSize.heightSize(150, context),
              decoration: BoxDecoration(
                  color: AppColors.fieldFillColor,
                  borderRadius:
                      BorderRadius.circular(AppSize.widthSize(20, context))),
              child: familyManager.dishImage != null
                  ? Image.file(familyManager.dishImage!, fit: BoxFit.cover)
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
                          'اظافة صورة',
                          style: AppStyles.styleBold(12, context),
                        )
                      ],
                    ),
            ),
          ),
          SizedBox(height: AppSize.heightSize(20, context)),
          CustomTextField(
            title: 'اسم الطبق',
            hintText: 'اسم الطبق',
            onChanged: (value) {
              familyManager.addDishRequestModel.dishName = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'ارجوا ادخال اسم الطبق';
              }
              return null;
            },
          ),
          SizedBox(height: AppSize.heightSize(20, context)),
          CustomTextField(
            title: 'وصف الطبق',
            hintText: 'وصف الطبق',
            onChanged: (value) {
              familyManager.addDishRequestModel.description = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'ارجوا ادخال وصفا للطبق';
              }
              return null;
            },
          ),
          SizedBox(height: AppSize.heightSize(20, context)),
          CustomTextField(
            title: 'السعر',
            hintText: 'السعر',
            onChanged: (value) {
              familyManager.addDishRequestModel.dishPrice =
                  double.tryParse(value);
            },
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'ارجوا ادخال السعر';
              }
              return null;
            },
          ),
          SizedBox(height: AppSize.heightSize(20, context)),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  title: 'ساعة',
                  hintText: '00',
                  onChanged: (value) {
                    //familyManager.preparationHours = int.tryParse(value) ?? 0;
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (familyManager.preparationTime == null) {
                      return 'ارجوا ادخال وقت التحضير';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: AppSize.widthSize(10, context)),
              Expanded(
                child: CustomTextField(
                  title: 'دقيقة',
                  hintText: '00',
                  onChanged: (value) {
                    //familyManager.preparationMinutes = int.tryParse(value) ?? 0;
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (familyManager.preparationTime == null) {
                      return 'ارجوا ادخال وقت التحضير';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: AppSize.widthSize(10, context)),
              Expanded(
                child: CustomTextField(
                  title: 'ثانية',
                  hintText: '00',
                  onChanged: (value) {
                    //familyManager.preparationSeconds = int.tryParse(value) ?? 0;
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (familyManager.preparationTime == null) {
                      return 'ارجوا ادخال وقت التحضير';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.heightSize(30, context)),
          ElevatedButton(
            onPressed: () async {
              await familyManager.addNewDishFunction();
            },
            child: Text('اظافة'),
          ),
        ],
      ),
    );
  }
}
