import 'package:flutter/material.dart';

import '../../../Utils/Constants/app_styles.dart';
import '../../Both/all_messages_screen.dart';

class UserAllMessages extends StatelessWidget {
  const UserAllMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'الرسائل',
          style: AppStyles.styleBold(18, context),
        ),
      ),
      body: const AllMessagesScreen(),
    );
  }
}
