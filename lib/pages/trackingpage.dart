import 'package:flutter/material.dart';
import 'dart:math';
import 'package:eloproject/pages/FinishingPage.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;
import 'dart:async';

class MyTrackingPage extends StatefulWidget {
  String inputStr = '';
  MyTrackingPage(this.inputStr);
  @override
  createState() => _MyTrackingPageState(this.inputStr);
}

class _MyTrackingPageState extends State<MyTrackingPage> {
  ScrollController _controller = new ScrollController();
  int _counter = 0;
  String inputStr = '';
  Position _currentPosition, initiaPosition,startPosition,endPosition;
  double _distance;
  int dis, sumDistance,prevDistance;
  bool hasStartPoint;
  _MyTrackingPageState(this.inputStr) {
    hasStartPoint = false;
    sumDistance = 0;
    prevDistance = 0;
    _timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      if (sumDistance >= int.parse(inputStr)) {
        _gotoNextPage();
      }
      _getCurrentLocation();
    });
  }

  _gotoNextPage() {
    _timer.cancel();
    endPosition = _currentPosition;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FinishingPage(startPosition,endPosition,int.parse(inputStr))),
    );
  }

  List<String> item = List();
  String temp;
  Timer _timer;

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        if (hasStartPoint) {
          _distance =
              _getDistanceFromLatLonInMetere(initiaPosition, _currentPosition);
          sumDistance += _distance.toInt();
        }else{
          startPosition = _currentPosition;
        }
        initiaPosition = _currentPosition;
        hasStartPoint = true;
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getDistanceFromLatLonInMetere(
    Position firstPosition, Position secondPosition) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((secondPosition.latitude - firstPosition.latitude) * p) / 2 +
        c(firstPosition.latitude * p) *
            c(secondPosition.latitude * p) *
            (1 - c((secondPosition.longitude - firstPosition.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.all(50.0),
                child: Text('TRACKING NOW...',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  new ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _controller,
                    shrinkWrap: true,
                    children: item.map((element) => Text(element)).toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print("Input Dstance: $inputStr");
          _counter++;
          dis = sumDistance - prevDistance;
          prevDistance = sumDistance;
          print("distance int:  $dis");
          setState(() {
            print(
                "Len: ${_currentPosition.latitude} Lon: ${_currentPosition.longitude}. cover distance: $_distance");
            temp = "CheckPoint$_counter  Total Distance: ${sumDistance}m   Last Distance: ${dis}m";
            item.add(temp);
          });
        },
        label: Text(
          '   ADD CHECKPOINT   ',
          style: TextStyle(fontSize: 20.0),
        ),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
