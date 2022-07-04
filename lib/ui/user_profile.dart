import 'package:bebandung/config/constant.dart';
import 'package:bebandung/config/global_style.dart';
import 'package:bebandung/model/user_model.dart';
import 'package:bebandung/ui/change_password.dart';
import 'package:bebandung/ui/edit_profile.dart';
import 'package:bebandung/ui/home.dart';
import 'package:bebandung/ui/reusable_widget.dart';
import 'package:bebandung/ui/reusable/cache_image_network.dart';
import 'package:bebandung/ui/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  // initialize reusable widget
  final _reusableWidget = ReusableWidget();

  final user = FirebaseAuth.instance.currentUser;
  Users? loggedInUser;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = Users.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loggedInUser == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: GlobalStyle.appBarIconThemeColor,
              ),
              systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
              centerTitle: true,
              title: Text('User Profile', style: GlobalStyle.appBarTitle),
              backgroundColor: GlobalStyle.appBarBackgroundColor,
              bottom: _reusableWidget.bottomAppBar(),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        (context),
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false);
                  },
                  icon: Icon(Icons.keyboard_arrow_left_rounded)),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  EditProfileScreen(user: loggedInUser!))));
                    },
                    icon: Icon(Icons.edit_rounded))
              ],
            ),
            body: Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _createProfilePicture(),
                    SizedBox(height: 40),
                    Text('Name', style: GlobalStyle.userProfileTitle),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(loggedInUser!.name!,
                              style: GlobalStyle.userProfileValue),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text('Email', style: GlobalStyle.userProfileTitle),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(loggedInUser!.email!,
                              style: GlobalStyle.userProfileValue),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text('Phone Number', style: GlobalStyle.userProfileTitle),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(loggedInUser!.phone!,
                              style: GlobalStyle.userProfileValue),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Center(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.orange)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          ChangePasswordScreen(
                                              user: loggedInUser!))));
                            },
                            child: Text('Change Password'))),
                    SizedBox(
                      height: 12,
                    ),
                    Center(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.orange)),
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              FirebaseAuth.instance.signOut().then((value) {
                                prefs.remove('email');
                                Navigator.pushAndRemoveUntil(
                                    (context),
                                    MaterialPageRoute(
                                        builder: (context) => Signin()),
                                    (route) => false);
                              });
                            },
                            child: Text('Logout'))),
                  ],
                ),
              ),
            ));
  }

  Widget _createProfilePicture() {
    final double profilePictureSize = MediaQuery.of(context).size.width / 3;
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(top: 40),
        width: profilePictureSize,
        height: profilePictureSize,
        child: GestureDetector(
          onTap: () {
            _showPopupUpdatePicture();
          },
          child: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: (profilePictureSize),
                child: Hero(
                  tag: 'profilePicture',
                  child: ClipOval(
                      child: buildCacheNetworkImage(
                          width: profilePictureSize,
                          height: profilePictureSize,
                          url: GLOBAL_URL + '/assets/images/user/avatar.png')),
                ),
              ),
              // create edit icon in the picture
              Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(
                    top: 0, left: MediaQuery.of(context).size.width / 4),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 1,
                  child: Icon(Icons.edit, size: 12, color: BLACK55),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPopupUpdatePicture() {
    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('No', style: TextStyle(color: SOFT_BLUE)));
    Widget continueButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: 'Click edit profile picture',
              toastLength: Toast.LENGTH_SHORT);
        },
        child: Text('Yes', style: TextStyle(color: SOFT_BLUE)));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        'Edit Profile Picture',
        style: TextStyle(fontSize: 18),
      ),
      content: Text('Do you want to edit profile picture ?',
          style: TextStyle(fontSize: 13, color: BLACK77)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
