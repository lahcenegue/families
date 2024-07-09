import 'base_model.dart';

class MessagesModel extends BaseModel {
  final List<MessageData>? data;

  MessagesModel({
    super.status,
    super.errorCode,
    this.data,
  });

  factory MessagesModel.fromJson(Map<String, dynamic> json) {
    return MessagesModel(
      status: json['status'],
      errorCode: json['error_code'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => MessageData.fromJson(item))
          .toList(),
    );
  }
}

class MessageData {
  int? messageId;
  int? userId;
  int? storeId;
  String? message;
  int? time;
  String? userName;
  int? latestMessages;

  MessageData({
    this.messageId,
    this.userId,
    this.storeId,
    this.message,
    this.time,
    this.userName,
    this.latestMessages,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      messageId: json['MessageId'],
      userId: json['UserId'],
      storeId: json['StoreId'],
      message: json['Message'],
      time: json['Time'],
      userName: json['UserName'],
      latestMessages: json['latest_messages'],
    );
  }
}
