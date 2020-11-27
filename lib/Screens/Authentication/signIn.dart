import 'package:agriglance/Screens/Authentication/forgotPassword.dart';
import 'package:agriglance/Services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  var opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Agriglance")),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: RaisedButton(
                color: Colors.yellow,
                onPressed: () {
                  setState(() {
                    opacity = 1.0;
                  });
                  context
                      .read<AuthenticationService>()
                      .signIn(emailController.text, passwordController.text);
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: OutlineButton(
                splashColor: Colors.grey,
                onPressed: () {
                  setState(() {
                    opacity = 1.0;
                  });
                  context.read<AuthenticationService>().signInWithGoogle();
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
            Opacity(
              opacity: opacity,
              child: CircularProgressIndicator(
                backgroundColor: Colors.yellow,
                strokeWidth: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
