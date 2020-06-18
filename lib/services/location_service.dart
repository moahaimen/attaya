import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> mylocation() async {
  Future.delayed(const Duration(seconds: 2));
  final position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  return position;
}


///this func. will get the address of the province 
///by providing the name of the province with this form{بغداد, Irak}
 Future<Address> stateLocation(String query) async {
  final addresses = await Geocoder.local.findAddressesFromQuery(query);
  return addresses.first;
}


