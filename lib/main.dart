import 'package:agriglance/Services/authenticate.dart';
import 'package:agriglance/services/admob_service.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/Home/home.dart';
import 'Services/authentication_service.dart';

import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';


void main() async {
  configureApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (!kIsWeb)
    await FirebaseAdMob.instance
        .initialize(appId: AdMobService().getAdMobAppId());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthnticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
              create: (context) =>
                  context.read<AuthenticationService>().authStateChanges)
        ],
        child: MaterialApp(
          title: 'Agriglance',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            backgroundColor: Colors.grey,
            primaryColor: Colors.indigo[900],
          ),
          home: (kIsWeb)
              ? Home()
              : ((FirebaseAuth.instance.currentUser == null) ? Authenticate() : Home()),
        ));
  }
}
