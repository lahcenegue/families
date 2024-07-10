import 'package:intl/intl.dart';

import '../Models/all_messages_model.dart';

class MessageViewModel {
  final AllMessagesModel _messageModel;
  late final List<MessageItemViewModel> messages;

  MessageViewModel({required AllMessagesModel messageModel})
      : _messageModel = messageModel {
    messages = _messageModel.data
            ?.map((message) => MessageItemViewModel(message: message))
            .toList() ??
        [];
  }
}

class MessageItemViewModel {
  final AllMessageData _message;

  MessageItemViewModel({required AllMessageData message}) : _message = message;

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
