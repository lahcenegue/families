import 'base_model.dart';

class AllMessagesModel extends BaseModel {
  final List<AllMessageData>? data;

  AllMessagesModel({
    super.status,
    super.errorCode,
    this.data,
  });

  factory AllMessagesModel.fromJson(Map<String, dynamic> json) {
    return AllMessagesModel(
      status: json['status'],
      errorCode: json['error_code'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => AllMessageData.fromJson(item))
          .toList(),
    );
  }
}

class AllMessageData {
  int? messageId;
  int? userId;
  int? storeId;
  String? message;
  int? time;
  String? userName;
  String? storeName;
  int? latestMessages;

  AllMessageData({
    this.messageId,
    this.userId,
    this.storeId,
    this.message,
    this.time,
    this.userName,
    this.storeName,
    this.latestMessages,
  });

  factory AllMessageData.fromJson(Map<String, dynamic> json) {
    return AllMessageData(
      messageId: json['MessageId'],
      userId: json['UserId'],
      storeId: json['StoreId'],
      message: json['Message'],
      time: json['Time'],
      userName: json['UserName'],
      storeName: json['StoreName'],
      latestMessages: json['latest_messages'],
    );
  }
}
