import 'package:bebandung/model/user_model.dart';
import 'package:bebandung/ui/home.dart';
import 'package:bebandung/ui/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameEditingController.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
    phoneEditingController.dispose();
  }

  String? errorMessage;
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;

  Color _gradientTop = Color.fromARGB(255, 230, 75, 3);
  Color _gradientBottom = Color.fromARGB(255, 189, 62, 3);
  Color _mainColor = Color.fromARGB(255, 189, 62, 3);
  Color _underlineColor = Color(0xFFCCCCCC);

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: Platform.isIOS
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
          child: Form(
            key: _formKey,
            child: Stack(
              children: <Widget>[
                // top blue background gradient
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [_gradientTop, _gradientBottom],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                ),
                // set your logo here
                Container(
                    margin: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height / 20, 0, 0),
                    alignment: Alignment.topCenter,
                    child: Image.asset('assets/images/logo.png', height: 120)),
                ListView(
                  children: <Widget>[
                    // create form login
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.fromLTRB(32,
                          MediaQuery.of(context).size.height / 3.5 - 72, 32, 0),
                      color: Colors.white,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(24, 0, 24, 20),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                      color: _mainColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: nameEditingController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[600]!)),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: _underlineColor),
                                    ),
                                    labelText: 'Name',
                                    labelStyle:
                                        TextStyle(color: Colors.grey[700])),
                                validator: (value) {
                                  RegExp regex = RegExp(r'^.{3,}$');
                                  if (value!.isEmpty) {
                                    return ("Name cannot be Empty");
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ("Enter Valid name(Min. 3 Character)");
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  nameEditingController.text = value!;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: phoneEditingController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[600]!)),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: _underlineColor),
                                    ),
                                    labelText: 'Phone Number',
                                    labelStyle:
                                        TextStyle(color: Colors.grey[700]!)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please Enter Your Phone");
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  nameEditingController.text = value!;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: emailEditingController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[600]!)),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: _underlineColor),
                                    ),
                                    labelText: 'Email',
                                    labelStyle:
                                        TextStyle(color: Colors.grey[700])),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please Enter Your Email");
                                  }
                                  // reg expression for email validation
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return ("Please Enter a valid email");
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  nameEditingController.text = value!;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: passwordEditingController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[600]!)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: _underlineColor),
                                  ),
                                  labelText: 'Password',
                                  labelStyle:
                                      TextStyle(color: Colors.grey[700]),
                                  suffixIcon: IconButton(
                                      icon: Icon(_iconVisible,
                                          color: Colors.grey[700], size: 20),
                                      onPressed: () {
                                        _toggleObscureText();
                                      }),
                                ),
                                validator: (value) {
                                  RegExp regex = new RegExp(r'^.{6,}$');
                                  if (value!.isEmpty) {
                                    return ("Password is required for login");
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ("Enter Valid Password(Min. 6 Character)");
                                  }
                                },
                                onSaved: (value) {
                                  nameEditingController.text = value!;
                                },
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) =>
                                            _mainColor,
                                      ),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                    ),
                                    onPressed: () {
                                      // Fluttertoast.showToast(
                                      //     msg: 'Click create account',
                                      //     toastLength: Toast.LENGTH_SHORT);
                                      signUp(emailEditingController.text,
                                          passwordEditingController.text);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        'CREATE ACCOUNT',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    // create sign up link
                    Center(
                      child: Wrap(
                        children: <Widget>[
                          Text('Already have an account? '),
                          GestureDetector(
                            onTap: () {
                              // Fluttertoast.showToast(
                              //     msg: 'Click signin',
                              //     toastLength: Toast.LENGTH_SHORT);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signin()));
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  color: _mainColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Users userModel = Users();

    userModel.email = user!.email;
    userModel.name = nameEditingController.text;
    userModel.password = passwordEditingController.text;
    userModel.phone = phoneEditingController.text;
    userModel.id = user.uid;
    userModel.favouriteFoods = [];
    userModel.favouriteWisata = [];

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    prefs.setString('email', user.email!);
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}
