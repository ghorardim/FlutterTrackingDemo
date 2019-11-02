import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class FinishingPage extends StatelessWidget {
  Position startPosition, endPosition;
//  final databaseReference = Firestore.instance;
  int coverDistance;
  FinishingPage(
      Position startPosition, Position endPosition, int coverDistance) {
    this.startPosition = startPosition;
    this.endPosition = endPosition;
    this.coverDistance = coverDistance;
  //  createRecord();
  }

  // void createRecord() async {
  //   DocumentReference ref =
  //       await databaseReference.collection("TrackingDetails").add({
  //     'Start Position': this.startPosition,
  //     'End Position': this.endPosition,
  //     'Cover Distance': this.coverDistance
  //   });
  //   print(ref.documentID);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Dog App',
      home: Scaffold(
        body: Center(
          child: DecoratedBox(
            // here is where I added my DecoratedBox
            decoration: BoxDecoration(color: Colors.lightBlueAccent),
            child: Text('Congratulation!!!',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
