import 'package:json_annotation/json_annotation.dart';

part 'messages_model.g.dart';

@JsonSerializable()
class MessagesModel {
  final String status;
  final List<MessageData>? data;

  const MessagesModel({required this.status, this.data});

  factory MessagesModel.fromJson(Map<String, dynamic> json) =>
      _$MessagesModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessagesModelToJson(this);
}

@JsonSerializable()
class MessageData {
  @JsonKey(name: 'MessageId')
  final int messageId;

  @JsonKey(name: 'UserId')
  final int userId;

  @JsonKey(name: 'StoreId')
  final int storeId;

  @JsonKey(name: 'Message', defaultValue: '')
  final String message;

  @JsonKey(name: 'SentByUser')
  final int sentByUser;

  @JsonKey(name: 'Time')
  final int time;

  @JsonKey(name: 'UserName', defaultValue: '')
  final String userName;

  @JsonKey(name: 'StoreName', defaultValue: '')
  final String storeName;

  const MessageData({
    required this.messageId,
    required this.userId,
    required this.storeId,
    required this.message,
    required this.sentByUser,
    required this.time,
    required this.userName,
    required this.storeName,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) =>
      _$MessageDataFromJson(json);
  Map<String, dynamic> toJson() => _$MessageDataToJson(this);
}
