import 'package:recomendo/utils/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';

class OpeningHours extends StatelessWidget {
  final Recommendation recommendation;

  const OpeningHours({this.recommendation});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
        EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Row(children: <Widget>[
              TimePicker(recommendation.moFrom, "Monday From"),
              TimePicker(recommendation.moTill, "Monday Until"),
            ]),

            Row(children: <Widget>[
              TimePicker(recommendation.tueFrom, "Tuesday From"),
              TimePicker(recommendation.tueTill, "Tuesday Until"),
            ]),

            Row(children: <Widget>[
              TimePicker(recommendation.wedFrom, "Wednesday From"),
              TimePicker(recommendation.wedTill, "Wednesday Until"),
            ]),

            Row(children: <Widget>[
              TimePicker(recommendation.thurFrom, "Thursday From"),
              TimePicker(recommendation.thurTill, "Thursday Until"),
            ]),

            Row(children: <Widget>[
              TimePicker(recommendation.friFrom, "Friday From"),
              TimePicker(recommendation.friTill, "Friday Until"),
            ]),

            Row(children: <Widget>[
              TimePicker(recommendation.satFrom, "Saturday From"),
              TimePicker(recommendation.satTill, "Saturday Until"),
            ]),

            Row(children: <Widget>[
              TimePicker(recommendation.sunFrom, "Sunday From"),
              TimePicker(recommendation.sunTill, "Sunday Until"),
            ]),

            Row(children: <Widget>[
              TimePicker(
                  recommendation.holidayFrom, "Holiday From"),
              TimePicker(
                  recommendation.holidayTill, "Holiday Until"),
            ]),
          ],
        ));
  }
}
