import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Helprs/navigation_service.dart';
import '../../../Utils/Widgets/custom_loading_indicator.dart';
import '../../../Utils/Widgets/costum_snackbar.dart';
import '../Widgets/all_store_box.dart';

class AllFamiliesStore extends StatelessWidget {
  const AllFamiliesStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: Padding(
            padding: EdgeInsets.only(
              top: AppSize.widthSize(40, context),
              left: AppSize.widthSize(25, context),
              right: AppSize.widthSize(25, context),
            ),
            child: userManager.allFamiliesViewModel == null
                ? _buildLoadingIndicator(userManager)
                : _buildStoreList(context, userManager),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }

  Widget _buildLoadingIndicator(UserManagerProvider userManager) {
    return Center(
      child: CustomLoadingIndicator(isVisible: userManager.isApiCallProcess),
    );
  }

  Widget _buildStoreList(
      BuildContext context, UserManagerProvider userManager) {
    return ListView.separated(
      itemCount: userManager.allFamiliesViewModel!.stores.length,
      separatorBuilder: (context, index) =>
          SizedBox(height: AppSize.heightSize(20, context)),
      itemBuilder: (context, index) {
        final store = userManager.allFamiliesViewModel!.stores[index];
        return AllStoreBox(
          store: store,
          addToFavorite: () async {
            int? result =
                await userManager.addToFavorite(storeId: store.storeId!);
            if (!context.mounted) return;
            safeShowErrorMessage(context, result);
          },
        );
      },
    );
  }
}
