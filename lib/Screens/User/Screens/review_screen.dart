import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../Providers/app_settings_provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Widgets/custom_loading_indicator.dart';
import '../../../View_models/my_ordres_viewmodel.dart';

class AddReviewScreen extends StatelessWidget {
  final ItemViewModel item;

  const AddReviewScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'إضافة تقييم',
          style: AppStyles.styleBold(14, context),
        ),
      ),
      body: Consumer<UserManagerProvider>(
        builder: (context, userManager, _) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(AppSize.widthSize(20, context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDishHeader(context, item),
                    SizedBox(height: AppSize.heightSize(30, context)),
                    _buildRatingSection(context, userManager),
                    SizedBox(height: AppSize.heightSize(30, context)),
                    _buildReviewSection(context, userManager),
                    SizedBox(height: AppSize.heightSize(30, context)),
                    _buildSubmitButton(context, userManager),
                  ],
                ),
              ),
              if (userManager.isLoading)
                CustomLoadingIndicator(isVisible: userManager.isLoading),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDishHeader(BuildContext context, ItemViewModel item) {
    return Container(
      height: AppSize.heightSize(80, context),
      padding: EdgeInsets.all(AppSize.widthSize(10, context)),
      decoration: BoxDecoration(
        color: Provider.of<AppSettingsProvider>(context).isDark
            ? AppColors.darkContainerBackground
            : Colors.white,
        borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.widthSize(15, context)),
            child: CachedNetworkImage(
              imageUrl: item.firstImage!,
              width: AppSize.widthSize(80, context),
              height: AppSize.heightSize(80, context),
              fit: BoxFit.fill,
              progressIndicatorBuilder: (context, url, progress) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(width: AppSize.widthSize(12, context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.itemName!,
                  style: AppStyles.styleBold(16, context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSize.heightSize(5, context)),
                Text(
                  '${item.amount} اطباق',
                  style: AppStyles.styleMedium(14, context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection(
      BuildContext context, UserManagerProvider userManager) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تقييمك',
          style: AppStyles.styleBold(16, context),
        ),
        SizedBox(height: AppSize.heightSize(10, context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => userManager.setSelectedRating(index + 1),
              child: Icon(
                index < userManager.selectedRating
                    ? Icons.star
                    : Icons.star_border,
                color: AppColors.starColor,
                size: AppSize.iconSize(40, context),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildReviewSection(
      BuildContext context, UserManagerProvider userManager) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تعليقك',
          style: AppStyles.styleBold(16, context),
        ),
        SizedBox(height: AppSize.heightSize(10, context)),
        TextFormField(
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'اكتب تعليقك هنا...',
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppSize.widthSize(15, context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppSize.widthSize(15, context)),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
          ),
          onChanged: (value) {
            userManager.setReviewText(value);
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton(
      BuildContext context, UserManagerProvider userManager) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: userManager.isLoading
            ? null
            : () async {
                if (userManager.selectedRating == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('الرجاء اختيار تقييم'),
                    ),
                  );
                  return;
                }
                if (userManager.reviewText.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('الرجاء كتابة تعليق'),
                    ),
                  );
                  return;
                }
                await userManager.submitReview(
                  itemId: item.itemId!,
                  rating: userManager.selectedRating,
                );
                if (userManager.errorMessage == null) {
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                } else {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(userManager.errorMessage!)),
                  );
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding:
              EdgeInsets.symmetric(vertical: AppSize.heightSize(15, context)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.widthSize(10, context)),
          ),
        ),
        child: Text(
          'إرسال التقييم',
          style: AppStyles.styleBold(16, context),
        ),
      ),
    );
  }
}
