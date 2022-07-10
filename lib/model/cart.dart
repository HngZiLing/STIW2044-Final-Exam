class Cart {
  String? cartId;
  String? subjectName;
  String? subjectPrice;
  String? cartQuantity;
  String? subjectId;
  String? priceTotal;

  Cart(
      {this.cartId,
      this.subjectName,
      this.subjectPrice,
      this.cartQuantity,
      this.subjectId,
      this.priceTotal});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    subjectName = json['subject_name'];
    subjectPrice = json['subject_price'];
    cartQuantity = json['cart_quantity'];
    subjectId = json['subject_id'];
    priceTotal = json['price_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['subject_name'] = subjectName;
    data['subject_price'] = subjectPrice;
    data['cart_quantity'] = cartQuantity;
    data['subject_id'] = subjectId;
    data['price_total'] = priceTotal;
    return data;
  }
}