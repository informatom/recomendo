import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';
import 'package:latlong/latlong.dart';

class LeafletMap extends StatefulWidget {
  final Recommendation recommendation;

  const LeafletMap({
    Key key,
    @required this.recommendation,
  }) : super(key: key);

  @override
  State<LeafletMap> createState() {
    return LeafletMapState(this.recommendation);
  }
}

class LeafletMapState extends State<LeafletMap> {
  Recommendation recommendation;
  MapController mapController;
  LeafletMapState(this.recommendation);

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context ) {
    LatLng latlng = LatLng(recommendation.latitude ?? 0.0, recommendation.longitude ?? 0.0);
    double zoom = 17;

    mapController.onReady.then((_) {
      mapController.move(latlng, zoom);
    });

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
          zoom: zoom,
          center: latlng),
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
              point: latlng,
              builder: (ctx) =>
                  Container(
                    child: Icon(Icons.location_on, size: 48, color: Colors.deepOrange),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}


