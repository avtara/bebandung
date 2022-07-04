import 'package:bebandung/config/global_style.dart';
import 'package:bebandung/model/user_model.dart';
import 'package:bebandung/ui/edit_profile.dart';
import 'package:bebandung/ui/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  final Users user;
  const ChangePasswordScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  Color _underlineColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: GlobalStyle.appBarIconThemeColor,
        ),
        systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: GlobalStyle.appBarBackgroundColor,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.25,
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: currentPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[600]!)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _underlineColor),
                        ),
                        labelText: 'Current Password',
                        labelStyle: TextStyle(color: Colors.grey[700])),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your Current Passwword");
                      }
                      if (currentPasswordController.text !=
                          widget.user.password) {
                        return ("Password is not same");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      currentPasswordController.text = value!;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: newPasswordController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[600]!)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _underlineColor),
                        ),
                        labelText: 'New Password',
                        labelStyle: TextStyle(color: Colors.grey[700])),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your New Password");
                      }
                      if (value.length < 6) {
                        return ("Please Enter at least 6 character");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      newPasswordController.text = value!;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[600]!)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _underlineColor),
                        ),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.grey[700])),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your New Password");
                      } else if (value != newPasswordController.text) {
                        return 'Password is not same';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      confirmPasswordController.text = value!;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.user.id)
                            .update({
                          'password': newPasswordController.text,
                        });
                        FirebaseAuth.instance.currentUser!
                            .updatePassword(newPasswordController.text)
                            .then((value) => Navigator.pushAndRemoveUntil(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) => UserProfilePage()),
                                (route) => false));
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange)),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
