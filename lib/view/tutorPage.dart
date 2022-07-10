import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mytutor/view/profilePage.dart';
import 'package:mytutor/view/subscribePage.dart';
import '../config.dart';
import '../model/tutor.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import 'favouritePage.dart';
import 'mainpage.dart';

User user = User();

class TutorPage extends StatefulWidget {
  const TutorPage({Key? key}) : super(key:key);

  @override
  State<TutorPage> createState() => TutorPageState();
}

class TutorPageState extends State<TutorPage> {
  String titlecenter = "Loading...";
  List<Tutor> tutorlist = <Tutor>[];
  late double screenHeight, screenWidth, resWidth;
  var numOfPage, curPage = 1, color;
  TextEditingController searchTutor = TextEditingController();
  String search = "";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) { resWidth = screenWidth; } 
    else { resWidth = screenWidth * 0.75; }
    return Scaffold (
      appBar: AppBar(
        title: const Text('My Tutor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              loadSearchDialog();
            },
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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext content) => MainPage(user: user)
                  ));
                },
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
                icon: const Icon(Icons.person, color: Colors.white, size: 35,),
              ),
            ]
          ),
        ),
      ),
      body: tutorlist.isEmpty 
      ? Center(
        child: Text(titlecenter, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
      ) : Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0,10,0,0),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 1,
              children: List.generate(tutorlist.length, (index) {
                return InkWell(
                  splashColor: Colors.blue,
                  onTap: () => {loadTutorDetail(index)},
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
                            tutorlist[index].tutorName.toString(), textAlign: TextAlign.center, 
                            style: const TextStyle(fontSize: 22, fontFamily: 'Changa', color: Colors.indigo, height: 1.2)
                          ),
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            Flexible(
                              flex: 3, 
                              child: CachedNetworkImage(
                                imageUrl: Config.server + "/mytutor/php/mobile/assets/assets/tutors/" + tutorlist[index].tutorId.toString() + '.jpg',
                                fit: BoxFit.cover,
                                width: resWidth,
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              flex: 7,
                              child: Column(
                                children: [
                                  Text(tutorlist[index].tutorEmail.toString() + 
                                  "\n\n" + tutorlist[index].tutorPhone.toString(), 
                                  style: const TextStyle(fontFamily: 'Raleway', height: 1.5)),
                                ],
                              ),
                            )
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
                    onPressed: () => {loadTutor(index + 1, search)},
                    child: Text(
                      (index + 1).toString(), style: TextStyle(color: color),
                    )
                  ),
                );
              },
            ),
          ),
        ]
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadTutor(1, search);
  }

  void loadTutor(int pageNo, String search) {
    curPage = pageNo;
    numOfPage ?? 1;
    http.post(Uri.parse(Config.server + "/mytutor/php/mobile/php/load_tutor.php"),
    body: { 
      'pageNo': pageNo.toString(),
      'search' : search}
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numOfPage = int.parse(jsondata['numOfPage']);
        if (extractdata['tutor'] != null) {
          tutorlist = <Tutor>[];
          extractdata['tutor'].forEach((v) {
            tutorlist.add(Tutor.fromJson(v));
          });
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
              title: const Text( "Search ",),
              content: SizedBox(
                height: screenHeight / 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: searchTutor,
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
                        search = searchTutor.text;
                        Navigator.of(context).pop();
                        loadTutor(1, search);
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
  
  loadTutorDetail(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text(
              tutorlist[index].tutorName.toString(), textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18, fontFamily: 'Changa', color: Colors.indigo
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(48),
                      child: CachedNetworkImage(
                        imageUrl: Config.server + "/mytutor/php/mobile/assets/assets/tutors/" + tutorlist[index].tutorId.toString() + '.jpg',
                        fit: BoxFit.cover,
                        width: resWidth,
                        placeholder: (context, url) =>
                        const LinearProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    )
                  ),
                  const SizedBox(height:10),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                      width: 250,
                      height: 50,
                      decoration: const BoxDecoration (
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Color.fromARGB(255, 214, 231, 245)
                      ),
                      child: Text(tutorlist[index].tutorEmail.toString() + "\n" +
                      tutorlist[index].tutorPhone.toString(), textAlign: TextAlign.center, 
                      style: const TextStyle(fontSize: 12, fontFamily: 'Raleway', height:2)),
                    ),
                    const Text("\nSubject: ", style: TextStyle(fontFamily: 'Changa')),
                    Text(tutorlist[index].subjectName.toString(), style: const TextStyle(fontSize:14,fontFamily: 'Raleway')),
                    const Text("\nDescription: ", style: TextStyle(fontFamily: 'Changa')),
                    Text(tutorlist[index].tutorDesc.toString(), style: const TextStyle(fontSize:14, fontFamily: 'Raleway')),
                    const Text("\nDate Register: ", style: TextStyle(fontFamily: 'Changa')),
                    Text(tutorlist[index].tutorDatereg.toString(), style: const TextStyle(fontSize:14,fontFamily: 'Raleway')),
                  ]
                ),
              ],
            )
          ),
        );
      }
    );
  }
}