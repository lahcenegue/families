// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesModel _$MessagesModelFromJson(Map<String, dynamic> json) =>
    MessagesModel(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MessageData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessagesModelToJson(MessagesModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

MessageData _$MessageDataFromJson(Map<String, dynamic> json) => MessageData(
      messageId: (json['MessageId'] as num).toInt(),
      userId: (json['UserId'] as num).toInt(),
      storeId: (json['StoreId'] as num).toInt(),
      message: json['Message'] as String,
      sentByUser: (json['SentByUser'] as num).toInt(),
      time: (json['Time'] as num).toInt(),
      userName: json['UserName'] as String,
    );

Map<String, dynamic> _$MessageDataToJson(MessageData instance) =>
    <String, dynamic>{
      'MessageId': instance.messageId,
      'UserId': instance.userId,
      'StoreId': instance.storeId,
      'Message': instance.message,
      'SentByUser': instance.sentByUser,
      'Time': instance.time,
      'UserName': instance.userName,
    };
