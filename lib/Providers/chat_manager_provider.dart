import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/base_api.dart';
import '../Apis/get_all_messages.dart';
import '../Apis/get_user_messages_api.dart';
import '../Models/all_messages_model.dart';
import '../Models/messages_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/api_methods.dart';
import '../View_models/messages_viewmodel.dart';

class ChatManagerProvider extends ChangeNotifier {
  //SharedPreferences? _prefs;
  List<MessageData> messages = [];
  MessageViewModel? allMessages;
  bool isApiCallProcess = false;
  bool isDataInitialized = false;
  bool isPolling = false;

  String? token;

  final TextEditingController messageController = TextEditingController();

  Timer? _pollingTimer;

  ChatManagerProvider() {
    initializeData();
  }

  Future<void> initializeData() async {
    if (!isDataInitialized) {
      isApiCallProcess = true;
      notifyListeners();

      //_prefs = await SharedPreferences.getInstance();
      token = 'UfFqCtub4U';
      //token = _prefs!.getString(PrefKeys.token);

      await fetchAllMessages();

      isApiCallProcess = false;
      isDataInitialized = true;
      notifyListeners();
    }
  }

  Future<void> fetchAllMessages() async {
    RequestModel requestModel = RequestModel(
      method: ApiMethods.getAllMessages,
      token: token,
    );

    try {
      AllMessagesModel value =
          await getAllMessagesApi(requestModel: requestModel);
      if (value.status == 'Success') {
        allMessages = MessageViewModel(messageModel: value);
        notifyListeners();
      } else {
        print('Failed to fetch messages');
      }
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  Future<void> fetchUserMessages({required int userId}) async {
    print('++++++++++++ fecth user messages+++++++++++');
    if (!isPolling) {
      isApiCallProcess = true;
      notifyListeners();
    }

    RequestModel getUserMessagesRequest = RequestModel(
      method: ApiMethods.getUserMessages,
      token: token!,
      userId: userId,
      messageId: 0,
    );

    try {
      MessagesModel response = await getUserMessagesApi(
          getUserMessagesRequest: getUserMessagesRequest);
      if (response.status == 'Success') {
        messages = response.data!;
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching messages: $e');
    } finally {
      isApiCallProcess = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage({
    required int userId,
    required String message,
  }) async {
    RequestModel requestModel = RequestModel(
      method: ApiMethods.sendMessageFromStore,
      token: token,
      userId: userId,
      message: message,
    );

    try {
      final response = await baseApi(requestModel: requestModel);
      if (response.status == 'Success') {
        fetchUserMessages(userId: userId);
        fetchAllMessages();
      }
    } catch (e) {
      print('Error sending message: $e');
    } finally {
      isApiCallProcess = false;
      notifyListeners();
    }
  }

  void startPolling(int userId) {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      isPolling = true;
      fetchUserMessages(userId: userId).then((_) => isPolling = false);
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
  }

  @override
  void dispose() {
    stopPolling();
    messageController.dispose();
    super.dispose();
  }
}
