import 'package:flutter/material.dart';
import '../Screens/Authentication/signIn.dart';
import '../Screens/Authentication/signUp.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toogleView: toggleView);
    } else {
      return SignUp(toogleView: toggleView);
    }
  }
}
