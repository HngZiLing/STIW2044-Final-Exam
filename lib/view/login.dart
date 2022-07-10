import 'package:flutter/material.dart';
import 'package:mytutor/view/mainpage.dart';
import 'package:mytutor/view/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:mytutor/config.dart';
import 'package:http/http.dart' as http;
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import '../model/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen ({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  
  late double screenHeight, screenWidth, ctrwidth;
  bool remember = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadPref();
  }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if(screenWidth >= 800) {ctrwidth = screenWidth / 1.5;}
    if(screenWidth < 800) {ctrwidth = screenWidth;}

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
            Color.fromARGB(255, 115, 199, 255),
            Color.fromARGB(255, 180, 229, 252),
            Color.fromARGB(255, 227, 248, 252)
            ]
          )
        ),
          child: SizedBox(width: ctrwidth, height:screenHeight,
            child: Form(key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: screenHeight / 4,
                          width: screenWidth, 
                          child: Image.asset('assets/images/logo.png')
                        ),
                        Container(
                          height: screenHeight / 1.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.5),
                                blurRadius: 7,
                                offset: const Offset(4, 8),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20,),
                                const Text("User Login", 
                                  style: TextStyle(
                                    fontSize: 25, 
                                    fontFamily: 'Changa', 
                                    color: Colors.indigo, 
                                    height: 1.2
                                  )
                                ),
                                const SizedBox(height: 10,),
                                Padding(
                                  padding:const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller : emailController,
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25.0)
                                      )
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if(value == null || value.isEmpty) {return 'Please enter valid email';}
                                      bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
                                      ).hasMatch(value);
                                      if(!emailValid) {return 'Please enter valid email';}
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 5,),

                                Padding(
                                  padding:const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25.0)
                                      )
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    validator: (value) {
                                      if(value == null || value.isEmpty) {return 'Please enter your password';}
                                      if(value.length < 6) {return "Password must be at lease 6 characters";}
                                      return null;
                                    },
                                  ),
                                ),
                        
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Checkbox(
                                      value: remember, 
                                      onChanged: (bool? value) {
                                        onRememberMe(value!);
                                      },
                                    ),
                                    const Flexible(
                                      child: Text("Remember me", 
                                      style: TextStyle(fontFamily: 'Raleway', height: 1.5)),
                                    ),

                                    ElevatedButton(
                                      onPressed: loginUser,
                                      child: const Text('Login'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.amber,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)
                                        )
                                      ),
                                    )
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () => {
                                        Navigator.push(
                                          context, MaterialPageRoute(
                                            builder: (BuildContext context) => const RegisterPage()
                                          )
                                        )
                                      },
                                      child: const Text(
                                        "Create New Account", 
                                        style: TextStyle(fontFamily: 'Raleway', height: 1.5),
                                      ),
                                    ),
                                  ]
                                ),
                                const SizedBox(height: 10),
                              ]
                            )
                          )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          )
        )
      ),
    );
  }

  void saveRemovePref(bool value) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      String email = emailController.text;
      String password = passwordController.text;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if(value) {
        await prefs.setString('email', email);
        await prefs.setString('password', password);
        await prefs.setBool('remember', true);
        Fluttertoast.showToast(
          msg: "Preference Stored",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0
        );
      } else {
        await prefs.setString('email', '');
        await prefs.setString('password', '');
        await prefs.setBool("remember", false);
        emailController.text = "";
        passwordController.text = "";
        Fluttertoast.showToast(
          msg: "Preference Removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0
        );
      } 
    } else {
      Fluttertoast.showToast(
        msg: "Preference Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14.0
      );
      remember = false;
    }
  } 

  void onRememberMe(bool value) {
    remember = value;
    setState(() {
      if(remember) {saveRemovePref(true);}
      else {saveRemovePref(false);}
    });
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('password')) ?? '';
    remember = (prefs.getBool('remember')) ?? false;

    if (remember) {
      setState(() {
        emailController.text = email;
        passwordController.text = password;
        remember = true;
      });
    }
  }

  void loginUser() {
    FocusScope.of(context).requestFocus(FocusNode());
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: 'Login in progress', max:100);
    String email = emailController.text;
    String password = passwordController.text;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ProgressDialog pd = ProgressDialog(context: context);
      pd.show(msg: 'Logging in..', max: 100);
      http.post(
        Uri.parse(Config.server + "/mytutor/php/mobile/php/login_user.php"),
        body: {
          "userEmail": email, 
          "userPassword": password
        }
    ).then(
        (response) {
          var data = jsonDecode(response.body);
          if (response.statusCode == 200 && data['status'] == 'success') {
            Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0
            );
            pd.update(value:100, msg:"Completed");
            pd.close();
            var extractdata = data['data'];
            User user = User.fromJson(extractdata);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (content) => MainPage(
                  user: user,
                )
              )
            );
          } else {
            Fluttertoast.showToast(
              msg: "Wrong email or password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0
            );
            pd.update(value:100, msg:"Failed");
            pd.close();
            Navigator.pop(context);
          }
        }
      );
    }
  }
}