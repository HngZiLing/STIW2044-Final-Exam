import 'package:flutter/material.dart';
import 'login.dart';
import '../config.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}): super(key: key);
  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  late double screenHeight, screenWidth, ctrwidth;
  String pathAsset = 'assets/images/camera.jpeg';
  var image;
  bool remember = false;

  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();

  final TextEditingController nameRegController = TextEditingController();
  final TextEditingController emailRegController = TextEditingController();
  final TextEditingController pass1RegController = TextEditingController();
  final TextEditingController pass2RegController = TextEditingController();
  final TextEditingController phoneRegController = TextEditingController();
  final TextEditingController addressRegController = TextEditingController();
  bool agree = false;
  final formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800) {ctrwidth = screenWidth / 1.5;}
    if (screenWidth < 800) {ctrwidth = screenWidth;}

    return Scaffold(
      appBar: AppBar(
        title: const Text('New User'),
      ),

      body: SingleChildScrollView(
        child:Center(
          child:SizedBox( width:ctrwidth,
            child:Form(
              key: formKey,
              child:Column(
                // children: [
                //   Padding(
                //     padding: const EdgeInsets.fromLTRB(32,32,32,32),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       mainAxisSize: MainAxisSize.min,
                      children:[
                        const Text(
                          "Register New Account",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.indigo,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Card(
                          child: GestureDetector(
                            onTap: () => {takePictureDialog()},
                            child: SizedBox(
                              height: screenHeight / 2.5,
                              width: screenWidth,
                              child: image == null
                              ? Image.asset(pathAsset)
                              : Image.file(image,fit: BoxFit.cover,)
                            )
                          ),
                        ),
                  
                        const SizedBox(height: 10),
                  
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(focus1);
                          },
                          controller: nameRegController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            )
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {return 'Please enter valid username';}
                            return null;
                          },  
                        ),

                        const SizedBox(height:10),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          focusNode: focus1,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(focus2);
                          },
                          controller: emailRegController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0)
                            )
                          ),
                          validator: (value) {
                            if(value == null || value.isEmpty) {return 'Please enter valid email';}
                            bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                            if(!emailValid) {return 'Please enter a valid email';}
                            return null;
                          },
                        ),

                        const SizedBox(height:10),
                        TextFormField(
                                textInputAction: TextInputAction.next,
                                focusNode: focus2,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(focus3);
                                },
                                controller: pass1RegController,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width:2.0),
                                  )
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if(value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if(pass1RegController.text != pass2RegController.text) {
                                    return "Your password does not match";
                                  }
                                  if(value.length < 6) {
                                    return "Password must be at least 6 characters"; 
                                  }
                                  return null;
                                },
                              ),
                              
                              const SizedBox(height:10),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                focusNode: focus3,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(focus4);
                                },
                                controller: pass2RegController,
                                decoration: const InputDecoration(
                                  labelText: 'Re-enter Password',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width:2.0),
                                  )
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if(value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if(pass1RegController.text != pass2RegController.text) {
                                    return "Your password does not match";
                                  }
                                  if(value.length < 6) {
                                    return "Password must be at least 6 characters"; 
                                  }
                                  return null;
                                },
                              ),
                        
                        const SizedBox(height: 10),
                        TextFormField(
                                textInputAction: TextInputAction.next,
                                focusNode: focus4,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(focus5);
                                },
                                controller: phoneRegController,
                                keyboardType: const TextInputType.numberWithOptions(),
                                decoration: const InputDecoration(
                                  labelText: 'Phone No.',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide (width:2.0),
                                  )
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {return 'Please enter valid phone number';}
                                  if(value.length > 13){return "Phone number must be less than 13 digit";}
                                  return null;
                                },
                              ),

                        const SizedBox(height: 10),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          focusNode: focus5,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(focus6);
                          },
                          minLines: 6,
                          maxLines: 6,
                          controller: addressRegController,
                          decoration: const InputDecoration(
                            labelText: 'Home Address',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width:2.0),
                            )
                          ),
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return 'Please enter your home address';}
                              return null;
                          }
                        ),
                  
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Checkbox(
                              value: agree, 
                              onChanged: onChanged
                            ),

                            Flexible(
                              child: GestureDetector(
                                onTap: null,
                                child: const Text("Agree with terms",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)
                                ),
                              )
                            ),

                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              minWidth: 115,
                              height: 50,
                              child:  
                              const Text("Register"),
                              color: Colors.indigo,
                              elevation: 10,
                              onPressed: registerDialog,
                            )
                          ]
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            GestureDetector(
                              onTap: () => {
                               Navigator.push(
                                  context, MaterialPageRoute(
                                    builder: (BuildContext context) => const LoginScreen()
                                  ) 
                                )
                              },
                              child: const Text("Already Register? Login here",
                                style: TextStyle(
                                  fontSize:16.0,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
              )
            )
          )
        ),
      ),
    );
  }

  void registerDialog() {
    if (formKey.currentState!.validate() && image != null && agree) {
      formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            title: const Text("Register New User"),
            content: const Text("Are you sure?"),
            actions: <Widget>[
              TextButton(
                child: const Text("Yes"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  registerUser();
                },
              ),
              TextButton(
                child: const Text("No"),
                onPressed: () {Navigator.of(context).pop();},
              ),
            ],
          );
        },
      );
    }
  }

  void onChanged(bool? value) {
    setState(() {
      agree = value!;
    });
  }

  void registerUser() {
    FocusScope.of(context).requestFocus(FocusNode());
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: 'Registration in progress', max:100);
    String userName = nameRegController.text;
    String userEmail = emailRegController.text;
    String userPassword = pass1RegController.text;
    String userPhone = phoneRegController.text;
    String userAddress = addressRegController.text;
    String base64Image = base64Encode(image!.readAsBytesSync());
    http.post(
      Uri.parse(Config.server + "/mytutor/php/mobile/php/register_user.php"),
      body: {
        "user_name": userName,
        "user_email": userEmail,
        "user_password": userPassword,
        "user_phone":userPhone,
        "user_address": userAddress,
        "user_image": base64Image,
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
          Navigator.push(context, MaterialPageRoute
          (builder: (content) => const LoginScreen()));
        } else {
          Fluttertoast.showToast(
            msg: data['status'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0
          );
          pd.update(value:100, msg:"Failed");
          pd.close();
        }
      }
    );
  }

  takePictureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select from",),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () => {
                  Navigator.of(context).pop(),
                  galleryPicker(),
                },
                icon: const Icon(Icons.browse_gallery),
                label: const Text("Gallery")
              ),
              TextButton.icon(
                onPressed: () => {Navigator.of(context).pop(), cameraPicker()},
                icon: const Icon(Icons.camera_alt),
                label: const Text("Camera")
              ),
            ],
          )
        );
      },
    );
  }

  galleryPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      cropImage();
    }
  }

  cameraPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      cropImage();
    }
  }

  Future<void> cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      aspectRatioPresets: [CropAspectRatioPreset.square,],
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false
      ),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
    );
    if (croppedFile != null) {
      image = croppedFile;
      setState(() {});
    }
  }
}