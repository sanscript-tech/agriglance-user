import 'package:agriglance/Services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
  final TextStyle linkStyle = TextStyle(color: Colors.blue, fontSize: 20.0);

  final Function toogleView;

  SignUp({this.toogleView});

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
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: qualificationController,
              decoration:
                  InputDecoration(labelText: 'Educational Qualification'),
            ),
            TextField(
              controller: universityController,
              decoration: InputDecoration(labelText: 'University'),
            ),
            RaisedButton(
              color: Colors.yellow,
              onPressed: () {
                context
                    .read<AuthenticationService>()
                    .signIn(emailController.text, passwordController.text);
              },
              child: Text(
                "Sign Up",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an Account?  ', style: defaultStyle),
                GestureDetector(
                  onTap: () {
                    toogleView();
                  },
                  child: Container(
                    child: Text('Sign In', style: linkStyle),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
