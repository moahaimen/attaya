import 'package:attayairaq/consts/consts.dart';
import 'package:flutter/material.dart';



class MapScreen extends StatelessWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('الخريطة', context, false),
      body: Container(),
    );
  }
}