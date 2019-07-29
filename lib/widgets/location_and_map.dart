import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';

class LocationAndMap extends StatelessWidget {
  const LocationAndMap({
    Key key,
    @required this.recommendation,
  }) : super(key: key);

  final Recommendation recommendation;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Padding(
        padding:
        EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            // Location
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(children: <Widget>[
                  Expanded(
                      child: Text(
                          "Longitude: ${recommendation.longitude.toString()}")),
                  Expanded(
                      child: Text(
                          "Latitude: ${recommendation.latitude.toString()}")),
                ])),
          ],
        ));
  }
}
