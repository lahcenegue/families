import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/messages_model.dart';
import '../../Providers/chat_manager_provider.dart';
import '../../Providers/login_register_manager.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../Utils/Constants/app_size.dart';
import '../../Utils/Constants/app_strings.dart';
import '../../Utils/Constants/app_styles.dart';
import '../../View_models/messages_viewmodel.dart';

class ChatScreen extends StatelessWidget {
  final MessageItemViewModel message;

  const ChatScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final chatManager = ChatManagerProvider();
        chatManager.fetchUserMessages(userId: message.userId!);
        chatManager.startPolling(message.userId!);
        return chatManager;
      },
      child: Consumer<ChatManagerProvider>(
        builder: (context, chatManager, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                message.userName!,
                style: AppStyles.styleBold(14, context),
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
                            final isUserAccount =
                                Provider.of<LoginAndRegisterManager>(context)
                                        .accountType ==
                                    AppStrings.user;
                            final isMe =
                                message.sentByUser == (isUserAccount ? 0 : 1);

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
                    userId: message.userId!,
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
