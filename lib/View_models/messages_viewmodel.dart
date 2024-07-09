import 'package:intl/intl.dart';

import '../Models/messages_model.dart';

class MessageViewModel {
  final MessagesModel _messageModel;
  late final List<MessageItemViewModel> messages;

  MessageViewModel({required MessagesModel messageModel})
      : _messageModel = messageModel {
    messages = _messageModel.data
            ?.map((message) => MessageItemViewModel(message: message))
            .toList() ??
        [];
  }
}

class MessageItemViewModel {
  final MessageData _message;

  MessageItemViewModel({required MessageData message}) : _message = message;

  int? get messageId => _message.messageId;
  int? get userId => _message.userId;
  int? get storeId => _message.storeId;
  String? get message => _message.message;
  String? get userName => _message.userName;
  int? get latestMessages => _message.latestMessages;

  String? get time {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(_message.time! * 1000);
    return DateFormat('M/d/y HH:mm').format(dateTime);
  }
}
