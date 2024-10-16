import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';
import '../../../Utils/Widgets/costum_snackbar.dart';
import '../Widgets/all_store_box.dart';

class MyFavoriteStores extends StatefulWidget {
  const MyFavoriteStores({super.key});

  @override
  State<MyFavoriteStores> createState() => _MyFavoriteStoresState();
}

class _MyFavoriteStoresState extends State<MyFavoriteStores> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserManagerProvider>().fetchMyFavoriteStores();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: RefreshIndicator(
            onRefresh: userManager.fetchMyFavoriteStores,
            child: Padding(
              padding: EdgeInsets.only(
                top: AppSize.widthSize(40, context),
                left: AppSize.widthSize(25, context),
                right: AppSize.widthSize(25, context),
              ),
              child: _buildContent(context, userManager),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, UserManagerProvider userManager) {
    if (userManager.isApiCallProcess) {
      return const Center(child: CircularProgressIndicator());
    } else if (userManager.favoriteFamiliesViewModel == null ||
        userManager.favoriteFamiliesViewModel!.stores.isEmpty) {
      return Center(
        child: Text(
          'لم يتم العثور على المتاجر المفضلة.',
          style: AppStyles.styleBold(16, context),
        ),
      );
    } else {
      return _buildStoreList(context, userManager);
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'المفضلة',
        style: AppStyles.styleBold(14, context),
      ),
    );
  }

  Widget _buildStoreList(
      BuildContext context, UserManagerProvider userManager) {
    return ListView.separated(
      itemCount: userManager.favoriteFamiliesViewModel!.stores.length,
      separatorBuilder: (context, index) =>
          SizedBox(height: AppSize.heightSize(20, context)),
      itemBuilder: (context, index) {
        final store = userManager.favoriteFamiliesViewModel!.stores[index];
        return AllStoreBox(
          store: store,
          addToFavorite: () async {
            int? result =
                await userManager.addToFavorite(storeId: store.storeId!);
            if (context.mounted) {
              safeShowErrorMessage(context, result);
            }
          },
        );
      },
    );
  }
}
