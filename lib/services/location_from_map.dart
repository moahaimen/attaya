import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationFromMap {
  //for get one instance around applicatino running
  static final location = LocationFromMap._internal();
  factory LocationFromMap() {
    return location;
  }

  LocationFromMap._internal();

  LatLng  markerLocation ;
}
