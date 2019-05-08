import 'package:location/location.dart';

class GeolocationHelper {

  static GeolocationHelper _geolocationHelper;
  static Future<LocationData> _location;

  GeolocationHelper._createInstance();

  factory GeolocationHelper() {
    _geolocationHelper ??= GeolocationHelper._createInstance();
    return _geolocationHelper;
  }

  Future<LocationData> get location {
    _location ??= cacheLocation();
    return _location;
  }

  Future<LocationData> cacheLocation() async {
    LocationData currentLocation = await Location().getLocation();
    return currentLocation;
  }
}
