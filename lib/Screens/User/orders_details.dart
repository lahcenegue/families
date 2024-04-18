import 'package:families/Utils/Constants/app_size.dart';
import 'package:families/Utils/Constants/app_styles.dart';
import 'package:flutter/material.dart';

class OrdersDetails extends StatelessWidget {
  const OrdersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSize.widthSize(25, context)),
        child: ListView(
          children: [
            Text(
              'Orders details',
              style: AppStyles.styleBold(25, context),
            ),
            SizedBox(height: AppSize.heightSize(10, context)),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppSize.heightSize(10, context)),
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('title $index'),
                  ),
                );
              },
            ),
            SizedBox(height: AppSize.heightSize(40, context)),
            Container(
              width: AppSize.width(context),
              height: AppSize.heightSize(206, context),
              decoration: BoxDecoration(
                  color: const Color(0xffFC584E),
                  borderRadius:
                      BorderRadius.circular(AppSize.widthSize(20, context))),
              child: Text('data'),
            ),
          ],
        ),
      ),
    );
  }
}
