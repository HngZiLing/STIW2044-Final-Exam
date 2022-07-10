import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mytutor/view/profilePage.dart';
import 'package:mytutor/view/subscribePage.dart';
import 'package:mytutor/view/favouritePage.dart';
import 'package:mytutor/view/tutorPage.dart';
import '../config.dart';
import '../model/user.dart';
import 'mainpage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  final User user;
  final double totalPayable;

  const PaymentPage({Key? key, required this.user, required this.totalPayable}) 
  : super(key:key);

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  final Completer<WebViewController> controller =
    Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text('My Payment'),
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
                    builder: (BuildContext content) => MainPage(user: widget.user)));
                },
                icon: const Icon(Icons.menu_book,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext content) => const TutorPage()));
                },
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: WebView(
              initialUrl: Config.server +
              '/mytutor/php/mobile/php/payment.php?email=' +
              widget.user.userEmail.toString() +
              '&mobile=' + widget.user.userPhone.toString() +
              '&name=' + widget.user.userName.toString() +
              '&amount=' +  widget.totalPayable.toString(),
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                controller.complete(webViewController);
              },
            ),
          )
        ],
      )
    );
  }
}