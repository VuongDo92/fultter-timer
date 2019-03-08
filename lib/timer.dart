import 'dart:async';

import 'package:flutter/material.dart';

class TimerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TimerAppState();
  }
}

class TimerAppState extends State<TimerApp> {
  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed++;
      });
    }
  }

  @override
  void initState() {
    timer = Timer.periodic(duration, (i) {
      handleTick();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return MaterialApp(
        title: 'Welcome to Flutter',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Timer'),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextContainer(label: "HRS", value: hours.toString()),
                    CustomTextContainer(label: "MIN", value: minutes.toString()),
                    CustomTextContainer(label: "SEC", value: seconds.toString())
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                      child: Text(isActive ? 'STOP' : 'START'),
                      onPressed: () {
                        setState(() {
                          isActive = !isActive;
                        });
                      }),
                )
              ],
            ),
          ),
        ));
  }
}

class CustomTextContainer extends StatelessWidget {
  final String label;
  String value;

  CustomTextContainer({Key key, this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.black87, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 54, fontWeight: FontWeight.bold),
          ),
          Text(
            '$label',
            style: TextStyle(color: Colors.white70),
          )
        ],
      ),
    );
  }
}
