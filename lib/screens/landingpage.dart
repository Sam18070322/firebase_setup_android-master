import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_setup_android/screens/Homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_setup_android/screens/login_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error : ${snapshot.error}"),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var user = snapshot.data;

                if (user == null) {
                  return LoginPage();
                } else {
                  return MeetAttendie();
                }
              }

              // Otherwise, show something whilst waiting for initialization to complete
              return Scaffold(
                body: Center(
                  child: Text("checking authentication"),
                ),
              );
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: Text("Connecting to the App..."),
          ),
        );
      },
    );
  }
}
