import 'package:agriglance/Screens/Authentication/forgotPassword.dart';
import 'package:agriglance/Screens/Home/home.dart';
import 'package:agriglance/Services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  final Function toogleView;

  SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
  final TextStyle linkStyle = TextStyle(color: Colors.blue, fontSize: 20.0);
  bool visible = false;

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Agriglance")),
      ),
      body: Center(
        child: Container(
          width: 400.0,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 25.0, // soften the shadow
              spreadRadius: 5.0, //extend the shadow
              offset: Offset(
                15.0,
                15.0,
              ),
            )
          ], color: Colors.yellow[50], border: Border.all(color: Colors.white)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("Images/logo.png"),
                    height: 200.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Container(
                      width: 350.0,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                    ),
                  ),
                  Container(
                    width: 350.0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: RaisedButton(
                      color: Colors.yellow,
                      onPressed: () async {
                        setState(() {
                          loadProgress();
                        });
                        await context
                            .read<AuthenticationService>()
                            .signIn(
                                emailController.text, passwordController.text)
                            .then((value) {
                          if (value == "Signed In") {
                            if (kIsWeb)
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            else
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                          } else {
                            setState(() {
                              loadProgress();
                            });
                            Fluttertoast.showToast(
                                msg: value,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM);
                          }
                        });
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visible,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.yellow,
                      strokeWidth: 8,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: OutlineButton(
                      splashColor: Colors.grey,
                      onPressed: () async {
                        setState(() {
                          loadProgress();
                        });
                        await context
                            .read<AuthenticationService>()
                            .signInWithGoogle()
                            .then((value) {
                          if (value == "Signed In") {
                            loadProgress();
                            if (kIsWeb)
                              Navigator.pop(context);
                            else
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                          } else {
                            setState(() {
                              loadProgress();
                            });
                            Fluttertoast.showToast(
                                msg: value,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM);
                          }
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      highlightElevation: 0,
                      borderSide: BorderSide(color: Colors.grey),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                                image: AssetImage("Images/google_logo.png"),
                                height: 35.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not Registered Yet?  ', style: defaultStyle),
                      GestureDetector(
                        onTap: () {
                          widget.toogleView();
                        },
                        child: Container(
                          child: Text('Sign Up', style: linkStyle),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                      child: Container(
                        child: Text('Forgot Password', style: linkStyle),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
