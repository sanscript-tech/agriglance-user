import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';

class AdMobService {
  String getAdMobAppId() {
    if (!kIsWeb) {
      return 'ca-app-pub-1485411163530319~3774536397';
    } else
      return null;
  }

  String getInterstitialAdId() {
    if (!kIsWeb) {
      // return 'ca-app-pub-3940256099942544/1033173712'; //This is test ID
      return 'ca-app-pub-1485411163530319/7917795532'; //This is production ID
    } else
      return null;
  }

  InterstitialAd getInterstitialAd() {
    return InterstitialAd(
      adUnitId: getInterstitialAdId(),
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
  }
}
