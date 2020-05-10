import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> mylocation() async {
  final position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  return position;
}

 Future<Address> stateLocation(String query) async {
  final addresses = await Geocoder.local.findAddressesFromQuery(query);
  return addresses.first;
}


