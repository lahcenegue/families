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

      // if (purchaseId != null) 'purchase_id': purchaseId,
      // if (dueDate != null) 'due_date': dueDate!.trim(),
      // if (itemName != null) 'item_name': itemName!.trim(),
      // if (itemPrice != null) 'item_price': itemPrice,
      // if (customerId != null) 'customer_id': customerId,
      // if (name != null) 'name': name!.trim(),
      // if (storeId != null) 'store_id': storeId,
      // if (startDate != null) 'starting_date': startDate!.trim(),
      // if (amount != null) 'amount': amount!,
      // if (otp != null) 'otp': otp!,
    };
  }
}
