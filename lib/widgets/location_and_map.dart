import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class LocationAndMap extends StatelessWidget {
  const LocationAndMap({
    Key key,
    @required this.recommendation,
  }) : super(key: key);

  final Recommendation recommendation;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .title;

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

            // Map
            Container(
            width: 400,
            height: 400,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(
                    recommendation.latitude ?? 0.0, recommendation.longitude ?? 0.0),
                zoom: 15.0,
                swPanBoundary: LatLng((recommendation.latitude ?? 0) - 0.2 , (recommendation.longitude ?? 0.0) - 0.2),
                nePanBoundary: LatLng((recommendation.latitude ?? 0) + 0.2 , (recommendation.longitude ?? 0.0) + 0.2),
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(
                          recommendation.latitude ?? 0.0, recommendation.longitude ?? 0.0),
                      builder: (ctx) =>
                          Container(
                            child: Icon(Icons.location_on),
                          ),
                    ),
                  ],
                ),
              ],

            ))
          ],
        ));
  }
}