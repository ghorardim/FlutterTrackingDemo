import 'package:eloproject/pages/trackingpage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();
  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  String inputStr = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 200.0,
              child: Padding(
                padding: EdgeInsets.all(50.0),
                child: Text('SET YOUR WALKING GOAL',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (text) {
                inputStr = text;
              },
                decoration:
                    InputDecoration(hintText: 'Set Tanget Distance (Meter)'),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print("Input Dstance: $inputStr");
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyTrackingPage(inputStr)),
            );
        },
        label: Text('   Start   ',style: TextStyle(fontSize: 20.0),),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
