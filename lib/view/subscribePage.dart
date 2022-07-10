import 'package:flutter/material.dart';
import 'package:mytutor/view/profilePage.dart';
import 'package:mytutor/view/tutorPage.dart';

import '../model/user.dart';
import 'favouritePage.dart';
import 'mainpage.dart';

User user = User();

class SubscribePage extends StatefulWidget {
  const SubscribePage({Key? key}) : super(key:key);

  @override
  SubscribePageState createState() => SubscribePageState();
}

class SubscribePageState extends State<SubscribePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text('My Subscribe'),
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
                      builder: (BuildContext content) => MainPage(user: user)));
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
    body: const Center(
      child: Text("Subscribe Page")
    ));
  }
}