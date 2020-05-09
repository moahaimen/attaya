import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> mylocation() async {
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print('object');
  print(position);

  return position;
}

 stateLocation(String query) async {
  final addresses = await Geocoder.local.findAddressesFromQuery(query);
  print('cordinate '+addresses.first.coordinates.toString());
  return addresses.first;
}
