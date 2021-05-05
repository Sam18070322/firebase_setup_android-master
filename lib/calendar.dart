import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DateWise",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
        child: DatePickerClass(),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class DatePickerClass extends StatefulWidget {
  @override
  _DatePickerClassState createState() => _DatePickerClassState();
}

class _DatePickerClassState extends State<DatePickerClass> {
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2019),
      lastDate: DateTime(2025),
    ))!;
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "${selectedDate.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            onPressed: () => _selectDate(context), // Refer step 3
            child: Text(
              'Pick Date',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            color: Colors.black,
          ),
          StreamBuilder(
              stream:
                  //FirebaseFirestore.instance.collection('170240107066').doc('attendance').snapshots(),
                  FirebaseFirestore.instance
                      .collection(_auth.currentUser!.uid.toString())
                      .doc("${selectedDate.toLocal()}".split(' ')[0])
                      .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  return Column(children: [
                    buildPresentlist(context, snapshot.data!.get('lec1')),
                    buildPresentlist(context, snapshot.data!.get('lec2'))
                  ]);
                }
                if (!snapshot.data!.exists) {
                  return Container(
                    child: noDataFound(context),
                  );
                } else {
                  return CircularProgressIndicator.adaptive();
                  //Container(child: Text(snapshot.data!.get('lec1').toString()));
                }
              })
        ],
      ),
    );
  }
}

Container noDataFound(context) {
  return Container(
    child: Center(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("graphics/error.gif",
                height: 350, width: 350, fit: BoxFit.cover),
            Text(
              "No Data Found",
              style: TextStyle(fontSize: 35),
            ),
          ],
        ),
      ),
    ),
  );
}

Column buildPresentlist(BuildContext context, documentz) {
  return Column(
    children: [
      Container(
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
                  documentz[0].toString() == "false"
                      ? Icons.close
                      : Icons.check,
                  color: documentz[0].toString() == "false"
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
                  child: Row(
                    children: [
                      Text(
                        "Class :",
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        documentz[1].toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                /* Row(
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
                        "${selectedDate.toLocal()}",
                        // documentz[2].toDate().toString().substring(0, 10),
                        // document['lec1'][2]
                        //    .toDate()
                        //    .toString()

                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    )
                   
                  ],
                ),*/
              ],
            )
          ],
        ),
      ),
    ],
  );
}
