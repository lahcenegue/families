import 'package:families/Constants/app_colors.dart';
import 'package:families/Constants/app_images.dart';
import 'package:families/Constants/app_styles.dart';
import 'package:families/Widgets/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/app_settings_provider.dart';
import '../../Widgets/custom_backgound.dart';
import '../../Widgets/ingridients_box.dart';

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
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      width: appSettings.width,
                      height: appSettings.height * 0.8,
                      padding: EdgeInsets.only(
                        top: appSettings.height * 0.1,
                        left: appSettings.width * 0.05,
                        right: appSettings.width * 0.05,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.fillColor,
                      ),
                      child: Center(
                        child: ListView(
                          children: [
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ingrigients',
                                  style: AppStyles.styleBold(context, 15),
                                ),
                                Text(
                                  '7 items',
                                  style: AppStyles.styleMedium(context, 13)
                                      .copyWith(
                                    color: AppColors.greyTextColors,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: appSettings.width,
                              height: 140,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              // color: Colors.white,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: 7,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 10),
                                itemBuilder: (context, index) {
                                  return const IngridientsBox(
                                    image: 'assets/images/brocoli.png',
                                    title: 'Brocoli',
                                  );
                                },
                              ),
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
                            Container(
                              width: appSettings.width,
                              height: appSettings.height * 0.2,
                              color: const Color(0xFF161616),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.only(top: appSettings.height * 0.12),
                    width: appSettings.width * 0.5,
                    child: Stack(
                      children: [
                        Image.asset(
                          AppImages.salade,
                        ),
                        Image.asset(
                          AppImages.plat,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, size.height * 0.1);

    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height * 0.1);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
