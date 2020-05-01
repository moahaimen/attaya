import 'package:attayairaq/consts/costume_nav_bar.dart';
import 'package:flutter/material.dart';

import 'package:attayairaq/consts/consts.dart';

class MapScreen extends StatelessWidget {
  final bool
      isNotSupScreen; //if the account is org account then its true otherwise its false
  const MapScreen({
    this.isNotSupScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   apBar('الخريطة', context) ,
      body: Container(),
      bottomNavigationBar: isNotSupScreen ? OrganizationNavBar() : null,
    );
  }
}
