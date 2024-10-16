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

class AllMessagesScreen extends StatefulWidget {
  const AllMessagesScreen({super.key});

  @override
  State<AllMessagesScreen> createState() => _AllMessagesScreenState();
}

class _AllMessagesScreenState extends State<AllMessagesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatManagerProvider>().initializeData();
      context.read<ChatManagerProvider>().fetchAllMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatManagerProvider>(
      builder: (context, chatManager, _) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: chatManager.fetchAllMessages,
            child: _buildMessagesContent(context, chatManager),
          ),
        );
      },
    );
  }

  Widget _buildMessagesContent(
    BuildContext context,
    ChatManagerProvider chatManager,
  ) {
    return Stack(
      children: [
        if (chatManager.isApiCallProcess)
          const Center(child: CircularProgressIndicator()),
        if (chatManager.allMessages == null ||
            chatManager.allMessages!.messages.isEmpty)
          _buildEmptyState(context)
        else
          _buildMessagesList(context, chatManager),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 3),
        Center(
          child: Text(
            AppLocalizations.of(context)!.no_messages,
            style: AppStyles.styleBold(16, context),
          ),
        ),
      ],
    );
  }

  Widget _buildMessagesList(
    BuildContext context,
    ChatManagerProvider chatManager,
  ) {
    return Container(
      margin: EdgeInsets.only(top: AppSize.heightSize(40, context)),
      color: Provider.of<AppSettingsProvider>(context).isDark
          ? AppColors.darkContainerBackground
          : Colors.white,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: chatManager.allMessages!.messages.length,
        itemBuilder: (context, index) {
          return _buildMessageTile(context, chatManager, index);
        },
      ),
    );
  }

  Widget _buildMessageTile(
    BuildContext context,
    ChatManagerProvider chatManager,
    int index,
  ) {
    final message = chatManager.allMessages!.messages[index];
    return ListTile(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              id: chatManager.accountType == AppStrings.family
                  ? message.userId!
                  : message.storeId!,
              title: chatManager.accountType == AppStrings.family
                  ? message.userName!
                  : message.storeName!,
            ),
          ),
        );
      },
      title: Text(
        chatManager.accountType == AppStrings.user
            ? message.storeName!
            : message.userName!,
        style: AppStyles.styleBold(12, context),
      ),
      subtitle: Text(
        message.message!,
        style: AppStyles.styleRegular(10, context),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            message.time!,
            style: AppStyles.styleRegular(10, context),
          ),
          message.latestMessages! == 0
              ? Icon(
                  Icons.check,
                  color: AppColors.primaryColor,
                )
              : Container(
                  width: AppSize.widthSize(25, context),
                  height: AppSize.widthSize(20, context),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.2),
                    borderRadius:
                        BorderRadius.circular(AppSize.widthSize(20, context)),
                  ),
                  child: Center(
                    child: Text(
                      '${message.latestMessages}',
                      style: AppStyles.styleBold(12, context).copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
