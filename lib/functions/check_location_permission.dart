import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
// import 'package:permission_handler/permission_handler.dart';

import '../consts/consts.dart';

///this function will check if [location Permission]
/// is granted and the [GPS] is on
Future checkLocationPermision({
  Function navigateToMap,
}) async {
  var location = Location();
  var permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.granted &&
      await location.serviceEnabled()) {
    navigateToMap();
  } else {
    await location.requestPermission();
    if (!await location.serviceEnabled() || Platform.isAndroid) {
      var isServiceGranted = await location.requestService();

      if (await location.hasPermission() == PermissionStatus.granted && isServiceGranted) {
        navigateToMap();
      } else {
        BotToast.showNotification(
          title: (cancelFunc) => Text(
            'يجب تفعيل الموقع الجغرافي',
            style: textStyle,
            textDirection: TextDirection.rtl,
          ),
        );
      }
    }
  }
}
