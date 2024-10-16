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
    if (!_disposed) {
      isApiCallProcess = true;
      notifyListeners();

      _prefs = await SharedPreferences.getInstance();
      accountType = _prefs!.getString(PrefKeys.accountType);
      token = _prefs!.getString(PrefKeys.token);

      isApiCallProcess = false;

      if (!_disposed) notifyListeners();
    }
  }

  Future<void> fetchAllMessages() async {
    isApiCallProcess = true;
    notifyListeners();

    RequestModel requestModel = RequestModel(
      method: accountType == AppStrings.user
          ? ApiMethods.getAllMessagesForUser
          : ApiMethods.getAllMessagesForStore,
      token: token,
    );

    try {
      AllMessagesModel value =
          await getAllMessagesApi(requestModel: requestModel);
      if (value.status == 'success') {
        allMessages = MessageViewModel(messageModel: value);
        notifyListeners();
      } else {
        debugPrint('Failed to fetch messages');
      }
    } catch (e) {
      debugPrint('Error fetching messages: $e');
    } finally {
      isApiCallProcess = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserMessages({required int id}) async {
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

    try {
      MessagesModel response = await getUserMessagesApi(
          getUserMessagesRequest: getUserMessagesRequest);

      if (response.status == 'success') {
        messages = response.data ?? [];
      } else {
        error = 'Failed to fetch messages: ${response.status}';
        debugPrint(error);
      }
    } catch (e) {
      error = 'Error fetching messages: $e';
      debugPrint(error);
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
      if (response.status == 'success') {
        fetchUserMessages(id: id);
        fetchAllMessages();
      }
    } catch (e) {
      debugPrint('Error sending message: $e');
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
