import 'package:bebandung/config/constant.dart';
import 'package:bebandung/library/sk_onboarding_screen/sk_onboarding_model.dart';
import 'package:bebandung/library/sk_onboarding_screen/sk_onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bebandung/ui/signin.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final pages = [
    SkOnboardingModel(
        title: 'Find destination and food',
        description: 'Choose the destination and food you want visit',
        titleColor: Colors.black,
        descripColor: Color(0xFF929794),
        imageFromUrl: GLOBAL_URL +
            '/assets/images/apps/food_delivery/onboarding/choose.png'),
    SkOnboardingModel(
        title: 'Enjoy',
        description: 'Enjoy destination information at home',
        titleColor: Colors.black,
        descripColor: Color(0xFF929794),
        imageFromUrl: GLOBAL_URL +
            '/assets/images/apps/food_delivery/onboarding/enjoy.png'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: SKOnboardingScreen(
        bgColor: Colors.white,
        themeColor: ASSENT_COLOR,
        pages: pages,
        skipClicked: (value) {
          //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Signin()));
        },
        getStartedClicked: (value) {
          //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Signin()));
        },
      ),
    ));
  }
}
