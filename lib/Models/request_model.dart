class RequestModel {
  String? method;
  int? phoneNumber;
  String? password;
  String? accountType;
  String? userName;
  String? email;
  String? storeName;
  String? location;
  String? storeImage;
  String? otpToken;
  int? otp;
  String? resetToken;
  String? query;
  int? storeId;
  int? itemId;
  String? token;
  int? amount;
  int? cartItemId;
  String? document;
  String? category;
  String? description;
  int? preparationTime;
  String? dishName;
  double? dishPrice;
  List<String>? dishImages;
  int? userId;
  String? message;
  int? messageId;
  String? oneSignalId;
  String? image;
  String? paymentMethode;

  RequestModel({
    this.method,
    this.phoneNumber,
    this.password,
    this.accountType,
    this.userName,
    this.email,
    this.storeName,
    this.location,
    this.storeImage,
    this.otpToken,
    this.otp,
    this.resetToken,
    this.query,
    this.storeId,
    this.itemId,
    this.token,
    this.amount,
    this.cartItemId,
    this.document,
    this.category,
    this.description,
    this.preparationTime,
    this.dishName,
    this.dishPrice,
    this.dishImages,
    this.userId,
    this.message,
    this.messageId,
    this.oneSignalId,
    this.image,
    this.paymentMethode,
  });

  Map<String, dynamic> toJson() {
    return {
      if (method != null) 'Method': method,
      if (phoneNumber != null) 'PhoneNumber': phoneNumber!,
      if (password != null) 'Password': password!.trim(),
      if (accountType != null) 'AccountType': accountType!.trim(),
      if (storeName != null) 'StoreName': storeName!.trim(),
      if (email != null) 'Email': email!.trim(),
      if (userName != null) 'UserName': userName!.trim(),
      if (location != null) 'Location': location!.trim(),
      if (storeImage != null) 'Image': storeImage!.trim(),
      if (otpToken != null) 'OtpToken': otpToken!.trim(),
      if (otp != null) 'Otp': otp!,
      if (resetToken != null) 'ResetToken': resetToken!.trim(),
      if (query != null) 'query': query!.trim(),
      if (storeId != null) 'StoreId': storeId!,
      if (itemId != null) 'ItemId': itemId!,
      if (token != null) 'Token': token!.trim(),
      if (amount != null) 'Amount': amount!,
      if (cartItemId != null) 'CartItemId': cartItemId!,
      if (document != null) 'Document1': document!.trim(),
      if (category != null) 'Category': category!.trim(),
      if (description != null) 'Description': description!.trim(),
      if (preparationTime != null) 'PreparationTime': preparationTime!,
      if (dishName != null) 'ItemName': dishName!.trim(),
      if (dishPrice != null) 'Price': dishPrice!,
      if (userId != null) 'UserId': userId!,
      if (message != null) 'Message': message!.trim(),
      if (messageId != null) 'MessageId': messageId!,
      if (oneSignalId != null) 'OneSignalId': oneSignalId!.trim(),
      if (image != null) 'Image': image!.trim(),
      if (dishImages != null) 'Images': dishImages!,
      if (paymentMethode != null) 'payment': paymentMethode!.trim(),
    };
  }
}
