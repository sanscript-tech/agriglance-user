import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agriglance/Screens/Materials/materials_home.dart';
import 'package:agriglance/services/admob_service.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'testSubjects.dart';

class TestHome extends StatefulWidget {
  @override
  _TestHomeState createState() => _TestHomeState();
}

List<String> _category_names = [];

class _TestHomeState extends State<TestHome> {
  void getCategories() async {
    await FirebaseFirestore.instance
        .collection("testCategories")
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                _category_names.add(doc['category']);
              })
            });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  Widget categoryButton(String category, BuildContext context) {
    final ams = (!kIsWeb) ? AdMobService() : null;
    var style;
    if (kIsWeb)
      style = TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Times',
      );
    else
      style = TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Times',
      );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 700.0,
        height: 100.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyan,
                Colors.blue[900],
                Colors.red,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 25.0, // soften the shadow
                spreadRadius: 5.0, //extend the shadow
                offset: Offset(
                  15.0,
                  15.0,
                ),
              )
            ],
            border: Border.all(color: Colors.white)),
        child: MaterialButton(
            splashColor: Colors.grey,
            hoverColor: Colors.amber,
            onPressed: () {
              if (!kIsWeb && noOfClicks % 5 == 0) {
                InterstitialAd newAd = ams.getInterstitialAd();
                newAd.load();
                newAd.show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                  horizontalCenterOffset: 0.0,
                );
                noOfClicks++;
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestSubject(
                            category: category,
                          )));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: AssetImage('Images/testIcon.png'),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  category,
                  style: style,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Icon(Icons.arrow_forward, color: Color(0xFF3EC3C1))
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey[300], width: 5.0))),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Container(
                  width: deviceWidth,
                  height: deviceHeight * 0.2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('Images/baner.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.green[900], BlendMode.softLight)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 25.0, // soften the shadow
                          spreadRadius: 5.0, //extend the shadow
                          offset: Offset(
                            15.0,
                            15.0,
                          ),
                        )
                      ],
                      color: Colors.indigo[900],
                      border: Border.all(color: Colors.white)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
                        child: SingleChildScrollView(
                          child: Text(
                            "Agriglance for Exam Preparation Like IBPS- AFO, Iffco, Kribhco, NFL,"
                            "NSC, and much more",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.yellow,
                                fontFamily: 'Times',
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Container(
                  width: 700.0,
                  height: deviceHeight * 2,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 25.0, // soften the shadow
                          spreadRadius: 5.0, //extend the shadow
                          offset: Offset(
                            15.0,
                            15.0,
                          ),
                        )
                      ],
                      color: Colors.yellow[50],
                      border: Border.all(color: Colors.white)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Test Categories",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Times',
                              fontSize: 25.0,
                              color: Colors.cyan[900],
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight / 25,
                      ),
                      Flexible(
                        child: ListView.builder(
                            primary: false,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _category_names.length,
                            itemBuilder: (context, index) {
                              return categoryButton(
                                  _category_names[index], context);
                            }),
                      ),
                      SizedBox(
                        height: deviceHeight / 25,
                      ),
                      if (kIsWeb)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Download Our Application from PlayStore"),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image(
                                    image: AssetImage("Images/playstore.png"),
                                    width: deviceWidth / 5,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Have any doubt? ask Admin or post "
                                "your question on our QNA Forum.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.orange, fontFamily: 'Times'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: deviceWidth,
                  height: 100.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.cyan,
                          Colors.blue[900],
                          Colors.red,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 25.0, // soften the shadow
                          spreadRadius: 5.0, //extend the shadow
                          offset: Offset(
                            15.0,
                            15.0,
                          ),
                        )
                      ],
                      border: Border.all(color: Colors.white)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Follow us on Social Media for daily Updates",
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                      SizedBox(
                        height: deviceHeight / 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                              child: FaIcon(
                                FontAwesomeIcons.facebookF,
                                color: Colors.blue[600],
                              ),
                              color: Colors.grey[300],
                              onPressed: () {
                                _launchURL(
                                    'https://www.facebook.com/Agriglance/?pageid=1587328474830432&ftentidentifier=2727538327476102&padding=0');
                              },
                              shape: CircleBorder()),
                          RaisedButton(
                              child: FaIcon(
                                FontAwesomeIcons.youtube,
                                color: Colors.red,
                              ),
                              color: Colors.grey[300],
                              onPressed: () {
                                _launchURL(
                                    'https://www.youtube.com/channel/UCTdud6FaN4rYas1OnHO6JoQ');
                              },
                              shape: CircleBorder()),
                          RaisedButton(
                              child: FaIcon(
                                FontAwesomeIcons.linkedin,
                                color: Colors.blue[900],
                              ),
                              color: Colors.grey[300],
                              onPressed: () {
                                _launchURL(
                                    'https://www.linkedin.com/in/agriglance-icar-6060ab9a/');
                              },
                              shape: CircleBorder()),
                        ],
                      ),
                    ],
                  ),
                ),
                if (kIsWeb)
                  Text("Copyright © 2020 - Agriglance | All rights reserved"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(url) async => await canLaunch(url)
      ? await launch(url)
      : Fluttertoast.showToast(msg: "Could not launch $url");
}
