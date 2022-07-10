import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/user.dart';
import '../config.dart';
import '../model/subject.dart';
import 'package:http/http.dart' as http;
import 'tutorPage.dart';
import 'subscribePage.dart';
import 'favouritePage.dart';
import 'profilePage.dart';
import 'cartPage.dart';

class MainPage extends StatefulWidget {
  final User user;
  const MainPage({Key? key, required this.user,}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  late List<Widget> tabchildren;
  String maintitle = "MyTutor";
  late double screenHeight, screenWidth, resWidth;
  String titlecenter = "Loading...";
  List<Subject> subjectlist = <Subject>[];
  var numOfPage, curPage = 1, color;
  TextEditingController searchCourse = TextEditingController();
  String search = "";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    
    if(screenWidth <= 600) {
      resWidth = screenWidth * 0.6;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tutor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () { loadSearchDialog();},
          ),
          TextButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (content) => CartPage(
                    user: widget.user,
                  )
                )
              );
              loadSubject(1, search);
              loadCart();
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            label: Text(widget.user.userCart.toString(), 
            style: const TextStyle(color: Colors.white,))
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber,
        child: SizedBox(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {MainPage(user: widget.user);},
                icon: const Icon(Icons.menu_book, color: Colors.white, size: 35,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext content) => const TutorPage()
                  ));
                },
                icon: const Icon(Icons.school, color: Colors.white, size: 35,),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext content) => const SubscribePage()
                  ));
                },
                icon: const Icon(Icons.notifications, color: Colors.white, size: 35,),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext content) => const FavouritePage()
                  ));
                },
                icon: const Icon(Icons.favorite_border, color: Colors.white, size: 35,),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext content) => const ProfilePage()
                  ));
                },
                icon: const Icon(Icons.person,color: Colors.white,size: 35,),
              ),
            ]
          ),
        ),
      ),
      body: subjectlist.isEmpty ? 
      Center(
        child: Text(titlecenter, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
      ) : Column(
        children: [
          const Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
          Expanded(
            child: GridView.count(
              crossAxisCount: 1,
              children: List.generate(subjectlist.length, (index) {
                return InkWell(
                  splashColor: Colors.blue,
                  onTap: () => {loadSubjectDetail(index)},
                  child: Card(
                    color: const Color.fromARGB(255, 214, 231, 245),
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Text(
                            subjectlist[index].subjectName.toString(), textAlign: TextAlign.center, 
                            style: const TextStyle(fontSize: 20, fontFamily: 'Changa', color: Colors.indigo, height: 1.2)
                          ),
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 25),
                            Expanded(
                              flex: 7,
                              child: CachedNetworkImage(
                                imageUrl: Config.server + "/mytutor/php/mobile/assets/assets/courses/" + subjectlist[index].subjectId.toString() + '.png',
                                fit: BoxFit.cover,
                                width: resWidth,
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              )
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Text("RM" + subjectlist[index].subjectPrice.toString() + 
                                  "\n\n" + subjectlist[index].subjectRating.toString() + "\u{2B50}", 
                                  style: const TextStyle(fontFamily: 'Raleway', height: 1.5)),
                                  IconButton(onPressed: () {
                                    addToCartDialog(index);
                                  },
                                  icon: const Icon(Icons.shopping_cart))
                                ],
                              ),
                            ),
                          ]
                        )
                      ],
                    )
                  )
                );
              })
            ),
          ),
          SizedBox(
            height: 30,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: numOfPage,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if ((curPage - 1) == index) { color = Colors.amber; } 
                else { color = Colors.indigo; }
                return SizedBox(
                  width: 40,
                  child: TextButton(
                    onPressed: () => {loadSubject(index + 1, "")},
                    child: Text(
                      (index + 1).toString(), style: TextStyle(color: color),
                    )
                  ),
                );
              },
            ),
          ),
        ]
      )
    );
  }

  @override
  void initState() {
    super.initState();
    loadSubject(1, search);
  }

  void loadSubject (int pageNo, String search) {
    curPage = pageNo; numOfPage ?? 1;
    http.post(
      Uri.parse(Config.server + "/mytutor/php/mobile/php/load_subject.php"),
      body: {  
        'pageNo': pageNo.toString(), 
        'search' : search
      }
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numOfPage = int.parse(jsondata['numOfPage']);
        if (extractdata['subject'] != null) {
          subjectlist = <Subject>[];
          extractdata['subject'].forEach((v) {
            subjectlist.add(Subject.fromJson(v));
          });
          setState(() {});
        } else {
          setState(() {});
        }
      }
    });
  }

  void loadSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text( "Search ",
              style: TextStyle(fontSize: 18, fontFamily: 'Changa', color: Colors.indigo),
              ),
              content: SizedBox(
                height: screenHeight / 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: searchCourse,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                        )
                      ),
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        search = searchCourse.text;
                        Navigator.of(context).pop();
                        loadSubject(1, search);
                      },
                      child: const Text("Search"),
                    )
                  ]
                )
              )
            );
          }
        );
      }
    );
  }
  
  loadSubjectDetail(int index) {
    showDialog(
    context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          title:Text(
            subjectlist[index].subjectName.toString(), textAlign: TextAlign.center,
            style: const TextStyle(
            fontSize: 18, fontFamily: 'Changa', color: Colors.indigo),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: CachedNetworkImage(
                    imageUrl: Config.server + "/mytutor/php/mobile/assets/assets/courses/" + subjectlist[index].subjectId.toString() + '.png',
                    fit: BoxFit.cover,
                    width: resWidth,
                    placeholder: (context, url) =>
                    const LinearProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                const SizedBox(height:10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    width: 250,
                    height: 65,
                    decoration: const BoxDecoration (
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Color.fromARGB(255, 214, 231, 245)
                    ),
                    child: Text("RM" + double.parse(subjectlist[index].subjectPrice.toString()).toStringAsFixed(2) + 
                    "\n" + subjectlist[index].subjectSessions.toString() + " sessions" + 
                    "\n" + subjectlist[index].subjectRating.toString() + "\u{2B50}",
                    textAlign: TextAlign.center, 
                    style: const TextStyle(fontSize: 14, fontFamily: 'Raleway', height:1.5)),
                  ),
                  const Text("\nDescription: ", style: TextStyle(fontFamily: 'Changa')),
                  Text(subjectlist[index].subjectDescription.toString(), 
                  style: const TextStyle(fontSize:14, fontFamily: 'Raleway')),
                ]),
              ],
            )
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height:50,  
                  width: screenWidth / 3,
                  child: ElevatedButton(
                    onPressed: () {
                      addToCartDialog(index);
                    },
                    child: const Text("Add to Cart")
                  )
                ),
                const SizedBox(width:10),
                SizedBox(
                  height: 50,
                  width: screenWidth / 3,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Add to subscribe")
                  )
                ),
              ]
            )
          ],
        );
      }
    );
  }
  
  addToCartDialog(int index) {
    showDialog(
    context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          title: const Text("Add To Cart", textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontFamily: 'Changa', color: Colors.indigo),
          ),
          content:
            const Text("Are you sure to add to cart?", 
              style: TextStyle(fontSize: 14, fontFamily: 'Raleway', height:1.5)
            ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => {addToCart(index),
                  Navigator.of(context).pop()},
                  child: const Text("Yes"),
                ),
                const SizedBox(width:10),
                TextButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  child: const Text("No"),
                ),
              ]
            )
          ],
        );
      }
    ).then((exit) {
      if(exit==null) return;
    });
  }

  void addToCart(int index) {
    http.post(
      Uri.parse(Config.server + "/mytutor/php/mobile/php/insert_cart.php"),
      body: {
        "userEmail": widget.user.userEmail.toString(),
        "subjectId": subjectlist[index].subjectId.toString(),
      }
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
          'Error', 408
        );
      }
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        setState(() {
          widget.user.userCart = jsondata['data']['cartTotal'].toString();
        });
        Fluttertoast.showToast(
         
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }
  
  void loadCart() {
    http.post(
      Uri.parse(
        Config.server + "/mytutor/php/mobile/php/load_cart_quantity.php"),
          body: {
            'userEmail': widget.user.userEmail.toString(),
          }).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response(
              'Error', 408);
        },
      ).then((response) {
        var jsondata = jsonDecode(response.body);
        if (response.statusCode == 200 && jsondata['status'] == 'success') {
          setState(() {
            widget.user.userCart = jsondata['data']['cartTotal'].toString();
          });
        }
      });
  }
}