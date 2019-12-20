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
  MinimalClock(ClockModel model);

  @override
  _MinimalClockState createState() => _MinimalClockState();
}

class _MinimalClockState extends State<MinimalClock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(
          children: <Widget>[
            Text("Set up for minimal clock")
          ],
        ),
      ),
    );
  }
}
