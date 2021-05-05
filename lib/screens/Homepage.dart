import 'package:flutter/material.dart';
import 'package:firebase_setup_android/calendar.dart';
import 'package:firebase_setup_android/home.dart';
import 'package:firebase_setup_android/profilepage.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(_auth.currentUser!.email.toString()),
        ),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    await signOut();
                  },
                  child: Text("SignOut")),
            ),
          ],
        ),
      ),
    );
  }
}

Future signOut() async {
  try {
    return await _auth.signOut();
  } catch (e) {
    print(e.toString());
    return null;
  }
}

class MeetAttendie extends StatefulWidget {
  @override
  _MeetAttendieState createState() => _MeetAttendieState();
}

class _MeetAttendieState extends State<MeetAttendie> {
  int _selectedItemIndex = 0;
  final List pages = [
    HomePage1(),
    CalendarPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Color(0xFFF0F0F0),
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            selectedIconTheme: IconThemeData(color: Colors.blueGrey[600]),
            currentIndex: _selectedItemIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              setState(() {
                _selectedItemIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.contact_page),
              ),
            ],
          ),
          body: pages[_selectedItemIndex]),
    );
  }
}
