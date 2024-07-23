import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/SplashScreen.dart';
import 'package:to_do_app/screens/dashBoard.dart';
import 'package:to_do_app/screens/login.dart';
import 'package:to_do_app/screens/signUP.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: FirebaseOptions(
        apiKey: "AIzaSyBQjujTsgvRIr9hTqVSoVwpvm2RinPbBi4",
        appId: "1:352058833058:android:8fb9fcdc8f62bb50c6bffb",
        messagingSenderId: "352058833058",
        projectId: "quicknotes-bc80d"));
    print('Firebase initialized successfully');

    //Enable firestore offline
    // it will save the data on the local device until the internet is not connected
    FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

    // authenticating user locally based on the data saved on the cache of the device
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To DO App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splashscreen(),
    );

  }
}



