import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final db = FirebaseFirestore.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Attendance",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('180243107006').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return buildPresentlist(context, document);
              }).toList(),
            );
          }),
    );
  }
}

Container buildPresentlist(BuildContext context, document) {
  return Container(
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(10),
    height: 100,
    decoration: BoxDecoration(
      color: Color(0xFFF9F9FB),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              document['lec1'][0].toString() == "False"
                  ? Icons.close
                  : Icons.check,
              color: document['lec1'][0].toString() == "False"
                  ? Colors.red
                  : Colors.green,
              size: 30,
            ),
          ],
        ),
        Container(
          height: 100,
          width: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 160,
              child: Text(
                "Class :" + document['lec1'][1].toString(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.date_range,
                  color: Colors.grey,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 160,
                  child: Text(
                    document['lec1'][2].toDate().toString().substring(0, 10),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                )
              ],
            ),
          ],
        )
      ],
    ),
  );
}
