import 'package:agriglance/Services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  var opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
                "We will send you a password reset link to your registered email address"),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Enter your registered email address'),
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
                    .resetPassword(emailController.text);
                showToast();
                Navigator.pop(context);
              },
              child: Text(
                "Send email",
                style: TextStyle(color: Colors.black),
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
    );
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: "Email Sent!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }
}
