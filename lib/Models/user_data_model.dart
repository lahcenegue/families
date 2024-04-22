class Data {
  String? phoneNumber;
  String? userName;
  String? email;
  String? token;
  String? accountType;

  Data({
    this.token,
    this.accountType,
    this.userName,
    this.email,
    this.phoneNumber,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'] ?? 'noToken',
      accountType: json['account_type'].toString(),
      userName: json['UserName'].toString(),
      email: json['email'].toString(),
      phoneNumber: json['phone_number'].toString(),
    );
  }
}
