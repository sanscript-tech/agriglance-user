import 'package:agriglance/Screens/Home/home.dart';
import 'package:agriglance/Services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final Function toogleView;

  SignUp({this.toogleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
  final TextStyle linkStyle = TextStyle(color: Colors.blue, fontSize: 20.0);
  String dob = "";
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
                  Container(
                    width: 350.0,
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Full Name'),
                    ),
                  ),
                  Container(
                    width: 350.0,
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                  ),
                  Container(
                    width: 350.0,
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                  ),
                  Container(
                    width: 350.0,
                    child: TextFormField(
                      controller: dobController,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _selectDate();
                      },
                      decoration: InputDecoration(labelText: 'Date of Birth'),
                    ),
                  ),
                  Container(
                    width: 350.0,
                    child: TextFormField(
                      controller: qualificationController,
                      decoration:
                          InputDecoration(labelText: 'Educational Qualification'),
                    ),
                  ),
                  Container(
                    width: 350.0,
                    child: TextFormField(
                      controller: universityController,
                      decoration: InputDecoration(labelText: 'University'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: RaisedButton(
                      color: Colors.yellow,
                      onPressed: () async {
                        setState(() {
                          loadProgress();
                        });
                        await context
                            .read<AuthenticationService>()
                            .signUp(
                                emailController.text,
                                passwordController.text,
                                nameController.text,
                                dobController.text,
                                qualificationController.text,
                                universityController.text)
                            .then((value) {
                          if (value == "Signed Up") {
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
                      child: Text(
                        "Sign Up",
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
                    padding: const EdgeInsets.all(25.0),
                    child: OutlineButton(
                      splashColor: Colors.grey,
                      onPressed: () {
                        setState(() {
                          loadProgress();
                        });
                        context
                            .read<AuthenticationService>()
                            .signInWithGoogle()
                            .then((value) {
                          if (value == "Signed In") {
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
                      Text('Already have an Account?  ', style: defaultStyle),
                      GestureDetector(
                        onTap: () {
                          widget.toogleView();
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
          ),
        ),
      ),
    );
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());
    if (picked != null)
      setState(() {
        dob = picked.toLocal().toString().split(" ")[0];
        dobController.text = dob;
      });
  }
}
