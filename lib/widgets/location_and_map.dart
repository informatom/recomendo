import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';
import 'leaflet_map.dart';

class LocationAndMap extends StatelessWidget {
  final Recommendation recommendation;

  const LocationAndMap({this.recommendation});

  @override
  Widget build(BuildContext context ) {
    return Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
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

            Container(
              width: 400,
              height: 400,
              child: LeafletMap(recommendation: recommendation)
            )
          ],
        )
    );
  }
}