import 'dart:io';

import 'package:location/location.dart';

///this function will check if [location Permission]
/// is granted and the [GPS] is on
Future<bool> checkLocationPermision() async {
  var location = Location();
  var permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.granted &&
      await location.serviceEnabled()) {
    return true;
  } else {
    await location.requestPermission();
    if (!await location.serviceEnabled() || Platform.isAndroid) {
      var isServiceGranted = await location.requestService();

      if (await location.hasPermission() == PermissionStatus.granted &&
          isServiceGranted) {
        return true;
      } else {
        return false;
        // BotToast.showNotification(
        //   title: (cancelFunc) => Text(
        //     'يجب تفعيل الموقع الجغرافي',
        //     style: textStyle,
        //     textDirection: TextDirection.rtl,
        //   ),
        // );
      }
    }
  }
  return false;
}
