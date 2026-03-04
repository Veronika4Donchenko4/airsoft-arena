import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDr1GTBVGW0kF3pzAMIU7pbZTdGieyZ-5Y",
            authDomain: "airsoft-romanov.firebaseapp.com",
            projectId: "airsoft-romanov",
            storageBucket: "airsoft-romanov.firebasestorage.app",
            messagingSenderId: "254149259649",
            appId: "1:254149259649:web:e4739385ae040beb66f880"));
  } else {
    await Firebase.initializeApp();
  }
}
