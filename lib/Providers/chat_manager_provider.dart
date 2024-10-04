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
import '../Utils/Constants/app_strings.dart';
import '../View_models/messages_viewmodel.dart';

class ChatManagerProvider extends ChangeNotifier {
  SharedPreferences? _prefs;

  String? accountType;
  List<MessageData> messages = [];
  MessageViewModel? allMessages;
  bool isApiCallProcess = false;
  bool isDataInitialized = false;
  bool isPolling = false;

  String? token;
  String? error;

  final TextEditingController messageController = TextEditingController();

  Timer? _pollingTimer;
  bool _disposed = false;

  ChatManagerProvider() {
    initializeData();
  }

  Future<void> initializeData() async {
    if (!isDataInitialized && !_disposed) {
      isApiCallProcess = true;
      notifyListeners();

      _prefs = await SharedPreferences.getInstance();
      accountType = _prefs!.getString(PrefKeys.accountType);
      token = _prefs!.getString(PrefKeys.token);

      await fetchAllMessages();

      isApiCallProcess = false;
      isDataInitialized = true;
      if (!_disposed) notifyListeners();
    }
  }

  Future<void> fetchAllMessages() async {
    print('fetch all messages');
    RequestModel requestModel = RequestModel(
      method: accountType == AppStrings.user
          ? ApiMethods.getAllMessagesForUser
          : ApiMethods.getAllMessagesForStore,
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

  Future<void> fetchUserMessages({required int id}) async {
    print('Fetching user messages for id: $id');
    if (!isPolling) {
      isApiCallProcess = true;
      error = null;
      notifyListeners();
    }

    RequestModel getUserMessagesRequest = RequestModel(
      method: accountType == AppStrings.family
          ? ApiMethods.getUserMessages
          : ApiMethods.getStoreMessages,
      token: token!,
      userId: accountType == AppStrings.family ? id : null,
      storeId: accountType == AppStrings.user ? id : null,
      messageId: 0,
    );

    print('Request token: ${getUserMessagesRequest.token}');

    try {
      print('Sending request: ${getUserMessagesRequest.toJson()}');
      MessagesModel response = await getUserMessagesApi(
          getUserMessagesRequest: getUserMessagesRequest);
      print('Received response: ${response.toJson()}');

      if (response.status == 'Success') {
        messages = response.data ?? [];
      } else {
        error = 'Failed to fetch messages: ${response.status}';
        print(error);
      }
    } catch (e) {
      error = 'Error fetching messages: $e';
      print(error);
    } finally {
      isApiCallProcess = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage({
    required int id,
    required String message,
  }) async {
    RequestModel requestModel = RequestModel(
      method: accountType == AppStrings.family
          ? ApiMethods.sendMessageFromStore
          : ApiMethods.sendMessageFromUser,
      token: token,
      userId: accountType == AppStrings.family ? id : null,
      storeId: accountType == AppStrings.user ? id : null,
      message: message,
    );

    try {
      final response = await baseApi(requestModel: requestModel);
      if (response.status == 'Success') {
        fetchUserMessages(id: id);
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
      fetchUserMessages(id: userId).then((_) => isPolling = false);
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
  }

  @override
  void dispose() {
    _disposed = true;
    stopPolling();
    messageController.dispose();
    super.dispose();
  }

  // void reset() {
  //   messages.clear();
  //   isDataInitialized = false;
  //   isApiCallProcess = false;
  //   isPolling = false;
  //   error = null;
  //   _disposed = false;
  // }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
