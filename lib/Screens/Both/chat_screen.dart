import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/messages_model.dart';
import '../../Providers/chat_manager_provider.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../Utils/Constants/app_size.dart';
import '../../Utils/Constants/app_strings.dart';
import '../../Utils/Constants/app_styles.dart';

class ChatScreen extends StatelessWidget {
  final int id;
  final String title;

  const ChatScreen({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final chatManager = ChatManagerProvider();

        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await chatManager.initializeData();
          await chatManager.fetchUserMessages(id: id);
          chatManager.startPolling(id);
        });

        return chatManager;
      },
      child: Consumer<ChatManagerProvider>(
        builder: (context, chatManager, _) {
          if (chatManager.error != null) {
            return Scaffold(
              appBar: AppBar(title: Text(title)),
              body: Center(child: Text('Error: ${chatManager.error}')),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                title,
                style: AppStyles.styleBold(18, context),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: chatManager.isApiCallProcess
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          reverse: true,
                          itemCount: chatManager.messages.length,
                          itemBuilder: (context, index) {
                            final message = chatManager.messages[index];

                            bool? isMe;
                            if (chatManager.accountType == AppStrings.family &&
                                message.sentByUser == 0) {
                              isMe = true;
                            } else if (chatManager.accountType ==
                                    AppStrings.user &&
                                message.sentByUser == 1) {
                              isMe = true;
                            } else {
                              isMe = false;
                            }

                            return _buildMessageItem(context, message, isMe);
                          },
                        ),
                ),
                _buildMessageInput(context, chatManager),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageItem(
      BuildContext context, MessageData message, bool isMe) {
    return Container(
      padding: EdgeInsets.all(AppSize.widthSize(5, context)),
      margin: EdgeInsets.symmetric(
        vertical: AppSize.widthSize(3, context),
        horizontal: AppSize.widthSize(10, context),
      ),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSize.heightSize(10, context),
          horizontal: AppSize.widthSize(15, context),
        ),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(AppSize.widthSize(20, context)),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              style: AppStyles.styleMedium(14, context).copyWith(
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: AppSize.heightSize(5, context)),
            Text(
              _formatTime(message.time),
              style: AppStyles.styleRegular(10, context).copyWith(
                color: isMe ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(
    BuildContext context,
    ChatManagerProvider chatManager,
  ) {
    return Padding(
      padding: EdgeInsets.all(AppSize.widthSize(8, context)),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: chatManager.messageController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'أكتب الرسالة هنا ..',
              ),
            ),
          ),
          SizedBox(width: AppSize.widthSize(8, context)),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                if (chatManager.messageController.text.isNotEmpty) {
                  chatManager.sendMessage(
                    id: id,
                    // id: chatManager.accountType == AppStrings.family
                    //     ? message.userId!
                    //     : message.storeId!,
                    message: chatManager.messageController.text,
                  );
                  chatManager.messageController.clear();
                }
              },
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
  }
}
