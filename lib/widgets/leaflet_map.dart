import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';

import 'package:latlong/latlong.dart';

class LeafletMap extends StatelessWidget {
  const LeafletMap({
    Key key,
    @required this.recommendation,
  }) : super(key: key);

  final Recommendation recommendation;

  @override
  Widget build(BuildContext context ) {
    FlutterMap map = FlutterMap(
      options: MapOptions(
          zoom: 16,
          center: LatLng(recommendation.latitude ?? 0.0, recommendation.longitude ?? 0.0)),
      layers: [
        TileLayerOptions(
          urlTemplate:
          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 150.0,
              height: 150.0,
              point: LatLng(recommendation.latitude ?? 0.0, recommendation.longitude ?? 0.0),
              builder: (ctx) =>
                  Container(
                    child: Icon(Icons.location_on),
                  ),
            ),
          ],
        ),
      ],
    );

    return map;
  }
}