import 'package:families/Constants/app_colors.dart';
import 'package:families/Constants/app_styles.dart';
import 'package:families/Models/ingridient_model.dart';
import 'package:families/Widgets/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/app_settings_provider.dart';
import '../../Widgets/custom_backgound.dart';
import '../../Widgets/ingridients_list.dart';
import '../../Widgets/product_background.dart';
import '../../Widgets/product_counter.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, appSettings, _) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                NavigationService.goBack();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          body: CustomBackground(
            child: Padding(
              padding: EdgeInsets.only(top: appSettings.height * 0.1),
              child: ProductBackground(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: EdgeInsets.all(
                          appSettings.width < 600 ? 12 : 25,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                height: appSettings.width < 600
                                    ? appSettings.height * 0.16
                                    : appSettings.height * 0.25),
                            Text(
                              'Fried Shrimp',
                              textAlign: TextAlign.center,
                              style: AppStyles.styleBold(context, 20),
                            ),
                            Text(
                              'This is my kind of breakfast egg sandwich and it takes under  5 minutes to make',
                              textAlign: TextAlign.center,
                              style:
                                  AppStyles.styleMedium(context, 13).copyWith(
                                color: AppColors.greyTextColors,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star_border_rounded,
                                  color: AppColors.greyTextColors,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '4.8(163)',
                                  style:
                                      AppStyles.styleBold(context, 12).copyWith(
                                    color: AppColors.greyTextColors,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Icon(
                                  Icons.timer_outlined,
                                  color: AppColors.greyTextColors,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '20 min',
                                  style:
                                      AppStyles.styleBold(context, 12).copyWith(
                                    color: AppColors.greyTextColors,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            const IngridientsList(
                              items: [
                                IngridientModel(
                                    image: 'assets/images/brocoli.png',
                                    title: 'Broccoli'),
                                IngridientModel(
                                    image: 'assets/images/chili.png',
                                    title: 'Chili'),
                                IngridientModel(
                                    image: 'assets/images/corn.png',
                                    title: 'Corn'),
                                IngridientModel(
                                    image: 'assets/images/carrot.png',
                                    title: 'Carrot'),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Image.asset('assets/images/41.png'),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Product family ',
                                      style: AppStyles.styleMedium(context, 20),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Color(0xffFDB022),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 40),
                            Row(
                              children: [
                                Text(
                                  'Size',
                                  style: AppStyles.styleRegular(context, 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: appSettings.width < 600 ? 12 : 25,
                          vertical: 20,
                        ),
                        //height: appSettings.height * 0.25,
                        width: appSettings.width,
                        decoration: const BoxDecoration(
                          color: Color(0xFF161616),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  r'$32',
                                  style: AppStyles.styleRegular(context, 28),
                                ),
                                const ProductCounter(),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('ADD TO CART'),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
