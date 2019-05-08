import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class GeolocationHelper {

  static GeolocationHelper _geolocationHelper;
  static LocationData _location;

  GeolocationHelper._createInstance();

  factory GeolocationHelper() {
    _geolocationHelper ??= GeolocationHelper._createInstance();
    return _geolocationHelper;
  }

  LocationData get location => (_location == null) ? cacheLocation() : _location;
  double get longitude => location.longitude;
  double get latitude => location.latitude;

  LocationData cacheLocation() {
    Location().getLocation().then((location) {
      _location = location;
      debugPrint(_location.longitude.toString());
      debugPrint(_location.latitude.toString());
      return _location;
    });
  }
}
