import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _Element {
  background,
  text,
  shadow,
}

class MinimalClock extends StatefulWidget {
  const MinimalClock(this.model);
  final ClockModel model;

  @override
  _MinimalClockState createState() => _MinimalClockState();
}

class _MinimalClockState extends State<MinimalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(MinimalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      // _timer = Timer(
      //   Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
      //   _updateTime,
      // );
    });
  }


  @override
  Widget build(BuildContext context) {
    String name = "Felix";

    final hour =
    DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute =
    DateFormat('mm').format(_dateTime);

    double sectionWidth = MediaQuery.of(context).size.width / 4;
    double sectionHeight = MediaQuery.of(context).size.height / 2;

    return Container(
      color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Time
                  Container(
                    color: Colors.deepOrangeAccent,
                    width: sectionWidth,
                    height: sectionHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("$hour", style: TextStyle(fontSize: 85, color: Colors.white,fontWeight: FontWeight.bold),),
                        Text("$minute",style: TextStyle(fontSize: 85,color: Colors.white, fontWeight: FontWeight.w100),),
                      ],
                    ),
                  ),
                  // Divider
                  Container(
                    color: Colors.white,
                    height: sectionHeight/1.05,
                    width: sectionWidth/45,
                    // Todo add radius and or margins
                  ),
                  // Greetings
                  Container(
                    color: Colors.red,
                    width: sectionWidth,
                    height: sectionHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(width: 50, height: 50, color: Colors.grey,),
                        ), // todo Icon
                        Text("Good Morning, ${name}!"),
                        Text("Today is December 19!"), //todo add date
                        Text("The weather is Sunny") // todo add weather
                        // todo maybe notifications?
                      ],
                    )
                  ),
                ],
              )
          ],
        )
    );
  }
}
