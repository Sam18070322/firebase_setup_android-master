import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  //CollectionReference users = FirebaseFirestore.instance.collection('170240107059');
  DateTime now = new DateTime.now();

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            //FirebaseFirestore.instance.collection('170240107066').doc('attendance').snapshots(),
            FirebaseFirestore.instance.collection('180243107006').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Stack(children: [
            headerArea(),
            Positioned(
              top: 185,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height - 245,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListView(
                    children: snapshot.data!.docs.map((document) {
                      return buildPresentlist(context, document);
                    }).toList(),
                  )),
            ),
          ]);
        });
  }

  Column buildPresentlist(BuildContext context, document) {
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
                    document['lec1'][0].toString() == "false"
                        ? Icons.close
                        : Icons.check,
                    color: document['lec1'][0].toString() == "false"
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
                          document['lec1'][2]
                              .toDate()
                              .toString()
                              .substring(0, 10),
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
        ),
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
                    document['lec2'][0].toString() == "false"
                        ? Icons.close
                        : Icons.check,
                    color: document['lec2'][0].toString() == "false"
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
                      "Class :" + document['lec2'][1].toString(),
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
                          document['lec2'][2]
                              .toDate()
                              .toString()
                              .substring(0, 10),
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
        )
      ],
    );
  }
}

Widget headerArea() {
  return StreamBuilder(
      stream:
          //FirebaseFirestore.instance.collection('170240107066').doc('attendance').snapshots(),
          FirebaseFirestore.instance.collection('170240107059').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return Container(
          decoration: BoxDecoration(
              //color: Color(0xFFD4E7FE),
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFD4E7FE),
                    Color(0xFFF0F0F0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.6, 0.3])),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: RichText(
                    text: TextSpan(
                  text: 'DATE : ' +
                      //now.day.toString() +
                      '-' +
                      //now.month.toString() +
                      '-',
                  //now.year.toString(),
                  style: TextStyle(
                      color: Color(0XFF263064),
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                )),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.shade900.withOpacity(0.2),
                          blurRadius: 12,
                          spreadRadius: 8,
                        )
                      ],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('graphics/avatar.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            //snapshot.data!.collection.id,
                            snapshot.data!.docs[0]['name'],
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Color(0XFF343E87),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data!.docs[0]['id'],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blueGrey,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        snapshot.data!.docs[0]['email'],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      });
}
