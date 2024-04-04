import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/app_images.dart';
import '../Providers/app_settings_provider.dart';
import 'dot_indicator.dart';

class CustomBanners extends StatelessWidget {
  const CustomBanners({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, appsettings, _) {
        return SizedBox(
          width: appsettings.width,
          height: appsettings.width * .6,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) => Container(
                    width: appsettings.width,
                    height: appsettings.width * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      image: const DecorationImage(
                        image: AssetImage(AppImages.banner1),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: appsettings.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    3,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: appsettings.width * 0.03),
                      child: const DotIndicator(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: appsettings.height * 0.01),
            ],
          ),
        );
      },
    );
  }
}
