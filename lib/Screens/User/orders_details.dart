import 'package:families/Utils/Constants/app_size.dart';
import 'package:families/Utils/Constants/app_styles.dart';
import 'package:families/Utils/Widgets/custom_backgound.dart';
import 'package:flutter/material.dart';

class OrdersDetails extends StatelessWidget {
  const OrdersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: EdgeInsets.all(AppSize.widthSize(25, context)),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Text(
                  'Orders details',
                  style: AppStyles.styleBold(25, context),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: AppSize.heightSize(10, context)),
              ),
              SliverFillRemaining(
                child: ListView.separated(
                  itemCount: 7,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: AppSize.heightSize(10, context)),
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text('title'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
