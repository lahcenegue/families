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
  String? token;

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
    this.token,
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
      if (token != null) 'Token': token!.trim(),
    };
  }
}
