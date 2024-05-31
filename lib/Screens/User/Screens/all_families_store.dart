import 'package:families/Utils/Constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Helprs/navigation_service.dart';
import '../../../Utils/Widgets/custom_loading_indicator.dart';
import '../../../Utils/Widgets/error_show.dart';
import '../Widgets/all_store_box.dart';

class AllFamiliesStore extends StatelessWidget {
  const AllFamiliesStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'الاسر المنتجة',
              style: AppStyles.styleBold(14, context),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  NavigationService.navigateTo(AppRoutes.searchScreen);
                },
                icon: Icon(
                  Icons.search,
                  size: AppSize.iconSize(24, context),
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              SizedBox(height: AppSize.heightSize(15, context)),
              SizedBox(height: AppSize.heightSize(25, context)),
              userManager.allFamiliesViewModel == null
                  ? Center(
                      child: CustomLoadingIndicator(
                          isVisible: userManager.isApiCallProcess),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(AppSize.widthSize(25, context)),
                      itemCount:
                          userManager.allFamiliesViewModel!.stores.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: AppSize.heightSize(10, context)),
                      itemBuilder: (context, index) => AllStoreBox(
                        store: userManager.allFamiliesViewModel!.stores[index],
                        addToFavorite: () async {
                          await userManager
                              .addToFavorite(
                                  storeId: userManager.allFamiliesViewModel!
                                      .stores[index].storeId!)
                              .then(
                                  (value) => errorMessagesShow(context, value));
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
