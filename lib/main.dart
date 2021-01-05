import 'package:agriglance/Screens/Home/Profile/profile.dart';
import 'package:agriglance/Services/authenticate.dart';
import 'package:agriglance/locator.dart';
import 'package:agriglance/navigation_service.dart';
import 'package:agriglance/route_names.dart';
import 'package:agriglance/services/admob_service.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agriglance/router.dart' as router;
import 'Screens/Home/home.dart';
import 'Services/authentication_service.dart';

import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

void main() async {
  setupLocator();
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
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
              create: (context) =>
                  context.read<AuthenticationService>().authStateChanges)
        ],
        child: MaterialApp(
          onGenerateRoute: router.generateRoute,
          initialRoute: homeViewRoute,
          navigatorKey: locator<NavigationService>().navigatorKey,
          title: 'Agriglance',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            backgroundColor: Colors.grey,
            primaryColor: Colors.indigo[900],
          ),
          // home: (kIsWeb)
          //     ? Home()
          //     : ((FirebaseAuth.instance.currentUser == null)
          //         ? Authenticate()
          //         : Home()),
        ));
  }
}
