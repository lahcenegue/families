import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Widgets/custom_loading_indicator.dart';
import '../Widgets/all_store_box.dart';
import '../Widgets/search_bar.dart';

class AllFamiliesStore extends StatelessWidget {
  const AllFamiliesStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('الاسر المنتجة'),
          ),
          body: ListView(
            children: [
              SizedBox(height: AppSize.heightSize(15, context)),
              searchBar(context),
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
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
