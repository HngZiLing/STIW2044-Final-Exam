import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytutor/view/profilePage.dart';
import 'package:mytutor/view/subscribePage.dart';
import 'package:mytutor/view/tutorPage.dart';
import 'package:mytutor/view/FavouritePage.dart';
import 'package:mytutor/view/paymentPage.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../model/user.dart';
import '../model/cart.dart';
import 'mainpage.dart';

class CartPage extends StatefulWidget {
  final User user;
  const CartPage({Key? key, required this.user}) : super(key:key);

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  List<Cart> cartList = <Cart>[];
  String titlecenter = "Loading...";
  late double screenHeight, screenWidth, resWidth;
  double totalPayable = 0.0;
  
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      //rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      //rowcount = 3;
    }

    return Scaffold (
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber,
        child: SizedBox(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext content) => MainPage(user: widget.user)));},
                icon: const Icon(Icons.menu_book,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext content) => const TutorPage()));},
                icon: const Icon(Icons.school,
                color: Colors.white,
                size: 35,
                ),
              ),
              IconButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext content) => const SubscribePage()));},
                icon: const Icon(Icons.notifications,
                color: Colors.white,
                size: 35,
                ),
              ),
              IconButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext content) => const FavouritePage()));},
                icon: const Icon(Icons.favorite_border,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(
                   builder: (BuildContext content) => const ProfilePage()));},
                icon: const Icon(Icons.person,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ]
          ),
        ),
      ),
      body: cartList.isEmpty
      ? Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(titlecenter,
            style: const TextStyle(fontSize: 14, fontFamily: 'Raleway', height:1.5,fontWeight: FontWeight.bold),
          ),
        ),
      )
      : Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
            Text(titlecenter,
              style: const TextStyle(fontSize: 20, fontFamily: 'Changa', color: Colors.indigo, height: 1.2)
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (1 / 1.3),
                
                children: List.generate(cartList.length, (index) {
                  return InkWell(
                    child: Card(
                      shadowColor: Colors.blueGrey,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Column(
                        children: [
                          Flexible(
                            flex: 7,
                            child: ClipRRect (
                              borderRadius: BorderRadius.circular(20.0),
                              child: CachedNetworkImage(
                              imageUrl: Config.server + "/mytutor/php/mobile/assets/assets/courses/" + 
                              cartList[index].subjectId.toString() + '.png',
                              
                              fit: BoxFit.cover,
                              width: resWidth,
                              placeholder: (context, url) => const LinearProgressIndicator(),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                            ),
                            )
                          ),
                          Text(
                            cartList[index].subjectName.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12, 
                              fontFamily: 'Raleway', 
                              height:1.5,
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("RM " + double.parse(cartList[index].priceTotal.toString()).toStringAsFixed(2),
                                style: const TextStyle(fontSize: 14, fontFamily: 'Raleway', height:1.5,fontWeight: FontWeight.bold)),
                                IconButton(
                                  onPressed: () {deleteItem(index);},
                                  icon: const Icon(Icons.delete_outlined)
                                )
                              ]
                            ),
                          )
                        ],
                      )
                    )
                  );
                })
              )
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Payable: ",
                    style: TextStyle(
                      fontSize: 16, 
                      fontFamily: 'Changa', 
                      color: Colors.indigo
                      ),
                    ),
                    Text("RM" + totalPayable.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 16, 
                      fontFamily: 'Raleway', 
                      height:1.5)
                    ),
                    ElevatedButton(
                      onPressed: onPaynowDialog,
                      child: const Text("Pay Now"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  void loadCart() {
    http.post(
      Uri.parse(Config.server + "/mytutor/php/mobile/php/load_cart.php"),
      body: {
        'user_email': widget.user.userEmail.toString(),
      }
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408); // Request Timeout response status code
      },
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        titlecenter = "Timeout Please retry again later";
        return http.Response('Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        if (extractdata['cart'] != null) {
          cartList = <Cart>[];
          extractdata['cart'].forEach((v) {
            cartList.add(Cart.fromJson(v));
          });
          int qty = 0;
          totalPayable = 0.00;
          for (var element in cartList) {
            qty = qty + int.parse(element.cartQuantity.toString());
            totalPayable = totalPayable + double.parse(element.priceTotal.toString());
          }
          titlecenter = qty.toString() + " Subjects in your cart";
          setState(() {});
        }
      } else {
        titlecenter = "Your Cart is Empty 😞 ";
        cartList.clear();
        setState(() {});
      }
    });
  }

  void onPaynowDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          title: const Text("Pay Now", textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontFamily: 'Changa', color: Colors.indigo),
            ),
          content: const Text("Are you sure?", 
          style: TextStyle(fontSize: 14, fontFamily: 'Raleway', height:1.5)),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes", style: TextStyle()),
              onPressed: () async {
                Navigator.of(context).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (content) => PaymentPage(
                    user: widget.user,
                    totalPayable: totalPayable)
                  )
                );
                loadCart();
              },
            ),
            TextButton(
              child: const Text("No",style: TextStyle()),
              onPressed: () {Navigator.of(context).pop();},
            ),
          ],
        );
      },
    );
  }

  void deleteItem(int index) {
    http.post(
      Uri.parse(Config.server + "/mytutor/php/mobile/php/delete_cart.php"),
      body: {
        'user_email': widget.user.userEmail,
        'cartId': cartList[index].cartId
      }
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        Fluttertoast.showToast(
          msg: "Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0
        );
        loadCart();
      } else {
        Fluttertoast.showToast(
          msg: "Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0
        );
      }
    });
  }
}