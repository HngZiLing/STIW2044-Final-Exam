class User {
  String? userId;
  String? userName;
  String? userEmail;
  String? userPassword;
  String? userPhone;
  String? userAddress;
  String? userCart;


  User(
    { this.userId,
      this.userName,
      this.userEmail,
      this.userPassword,
      this.userPhone,
      this.userAddress,
      this.userCart
    }
  );

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPassword = json['userPassword'];
    userPhone = json['userPhone'];
    userAddress = json['userAddress'];
    userCart = json['userCart'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['userEmail'] = userEmail;
    data['userPassword'] = userPassword;
    data['userPhone'] = userPhone;
    data['userAddress'] = userAddress;
    data['userCart'] = userCart.toString();
    return data;
  }
}