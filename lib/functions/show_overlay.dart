import 'dart:async';

import 'package:flutter/material.dart';

import '../consts/consts.dart';
import '../services/size_config.dart';

Future<void> showOverlay({
  @required BuildContext context,
  @required String text,
}) async {
  final overlayState = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 50.0,
      right: SizeConfig.screenWidth * 0.25,
      width: SizeConfig.screenWidth * 0.5,
      child: Material(
        color: Colors.white.withOpacity(0),
        child: Container(
          decoration: BoxDecoration(
            // border: Border.all(),
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.withOpacity(0.6),
          ),
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              text,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: textStyle.copyWith(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);

  await Future.delayed(const Duration(seconds: 2));

  overlayEntry.remove();
}
