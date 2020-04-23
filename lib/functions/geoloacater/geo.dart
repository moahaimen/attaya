import 'package:geolocator/geolocator.dart';
import 'dart:async';

Future<Position> mylocation() async {
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print('object');
  print(position);

  return position;
}
