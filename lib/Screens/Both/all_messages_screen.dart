import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/app_settings_provider.dart';
import '../../Providers/chat_manager_provider.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../Utils/Constants/app_size.dart';
import '../../Utils/Constants/app_strings.dart';
import '../../Utils/Constants/app_styles.dart';
import 'chat_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllMessagesScreen extends StatelessWidget {
  const AllMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatManagerProvider>(
      builder: (context, chatManager, _) {
        return Scaffold(
          body: chatManager.isApiCallProcess
              ? const Center(child: CircularProgressIndicator())
              : _buildMessagesContent(context, chatManager),
        );
      },
    );
  }

  Widget _buildMessagesContent(
      BuildContext context, ChatManagerProvider chatManager) {
    if (chatManager.allMessages == null ||
        chatManager.allMessages!.messages.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.no_messages,
          style: AppStyles.styleBold(16, context),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: AppSize.heightSize(40, context)),
        color: Provider.of<AppSettingsProvider>(context).isDark
            ? AppColors.darkContainerBackground
            : Colors.white,
        child: ListView.builder(
          itemCount: chatManager.allMessages!.messages.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      message: chatManager.allMessages!.messages[index],
                    ),
                  ),
                );
              },
              title: Text(
                chatManager.accountType == AppStrings.user
                    ? chatManager.allMessages!.messages[index].storeName!
                    : chatManager.allMessages!.messages[index].userName!,
                style: AppStyles.styleBold(12, context),
              ),
              subtitle: Text(
                chatManager.allMessages!.messages[index].message!,
                style: AppStyles.styleRegular(10, context),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    chatManager.allMessages!.messages[index].time!,
                    style: AppStyles.styleRegular(10, context),
                  ),
                  chatManager.allMessages!.messages[index].latestMessages! == 0
                      ? Icon(
                          Icons.check,
                          color: AppColors.primaryColor,
                        )
                      : Container(
                          width: AppSize.widthSize(25, context),
                          height: AppSize.widthSize(20, context),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(
                                AppSize.widthSize(20, context)),
                          ),
                          child: Center(
                            child: Text(
                              '${chatManager.allMessages!.messages[index].latestMessages}',
                              style: AppStyles.styleBold(12, context).copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        )
                ],
              ),
            );
          },
        ),
      );
    }
  }
}
