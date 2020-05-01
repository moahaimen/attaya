import 'dart:async';
import 'package:attayairaq/consts/consts.dart';
import 'package:attayairaq/services/size_config.dart';
import 'package:flutter/material.dart';

Future<void> showOverlay(
    {@required BuildContext context, @required String text}) async {
  final OverlayState overlayState = Overlay.of(context);
  final OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 30.0,
      child: Material(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.withOpacity(0.25),
          ),
          padding: const EdgeInsets.all(15),
          margin: EdgeInsets.only(left: SizeConfig.screenWidth * 0.35),
          child: FittedBox(
            child: Text(text, style: textStyle),
          ),
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);

  await Future.delayed(const Duration(seconds: 2));

  overlayEntry.remove();
}
