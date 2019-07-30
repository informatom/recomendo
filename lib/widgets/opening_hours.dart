import 'package:recomendo/utils/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';

class OpeningHours extends StatelessWidget {
  const OpeningHours({
    Key key,
    @required this.recommendation,
  }) : super(key: key);

  final Recommendation recommendation;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
        EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            // Monday opening hours
            Row(children: <Widget>[
              TimePicker(recommendation.moFrom, "Monday From"),
              TimePicker(recommendation.moTill, "Monday Until"),
            ]),

            // Tuesday opening hours
            Row(children: <Widget>[
              TimePicker(recommendation.tueFrom, "Tuesday From"),
              TimePicker(recommendation.tueTill, "Tuesday From"),
            ]),

            // Wednesday opening hours
            Row(children: <Widget>[
              TimePicker(recommendation.wedFrom, "Wednesday From"),
              TimePicker(recommendation.wedTill, "Wednesday From"),
            ]),

            // Thursday opening hours
            Row(children: <Widget>[
              TimePicker(recommendation.thurFrom, "Thursday From"),
              TimePicker(recommendation.thurTill, "Thursday From"),
            ]),

            // Friday opening hours
            Row(children: <Widget>[
              TimePicker(recommendation.friFrom, "Friday From"),
              TimePicker(recommendation.friTill, "Friday From"),
            ]),

            // Saturday opening hours
            Row(children: <Widget>[
              TimePicker(recommendation.satFrom, "Saturday From"),
              TimePicker(recommendation.satTill, "Saturday From"),
            ]),

            // Sunday opening hours
            Row(children: <Widget>[
              TimePicker(recommendation.sunFrom, "Sunday From"),
              TimePicker(recommendation.sunTill, "Sunday From"),
            ]),

            // Holiday opening hours
            Row(children: <Widget>[
              TimePicker(
                  recommendation.holidayFrom, "Holiday From"),
              TimePicker(
                  recommendation.holidayTill, "Holiday From"),
            ]),
          ],
        ));
  }
}