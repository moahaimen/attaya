import 'package:flutter/material.dart';

import '../../models/user.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int newIndex) onSelectedTap;
  final UserType userType;
  CustomNavBar({this.currentIndex, this.onSelectedTap, this.userType});

  final List<BottomNavigationBarItem> adminItems = [
    BottomNavigationBarItem(
        icon: const Icon(Icons.home, size: 30, color: Colors.white),
        title: Container()),
    BottomNavigationBarItem(
        icon: Image.asset('assets/icons/family_icon.png',
            width: 25, color: Colors.white),
        title: Container()),
    BottomNavigationBarItem(
        icon: Image.asset('assets/icons/map_pin_1.png', width: 25),
        title: Container()),
    BottomNavigationBarItem(
        icon: Image.asset('assets/icons/organization_icon.png', width: 25),
        title: Container()),
    BottomNavigationBarItem(
        icon: Image.asset('assets/icons/about_code_for_Iraq.png', width: 25),
        title: Container()),
    BottomNavigationBarItem(
        icon: Image.asset('assets/icons/about_app.png', width: 25),
        title: Container()),
  ];
  final List<BottomNavigationBarItem> familyItems = [
    BottomNavigationBarItem(
        icon: Image.asset('assets/icons/user_icon.png', width: 25),
        title: Container()),
    BottomNavigationBarItem(
        icon: Image.asset('assets/icons/organization_icon.png', width: 25),
        title: Container()),
    BottomNavigationBarItem(
        icon: Image.asset('assets/icons/about_code_for_Iraq.png', width: 25),
        title: Container()),
    BottomNavigationBarItem(
        icon: Image.asset('assets/icons/about_app.png', width: 25),
        title: Container()),
  ];
  final List<BottomNavigationBarItem> orgItems = [
    BottomNavigationBarItem(
        icon: const Icon(Icons.home, size: 30, color: Colors.white),
        title: Container()),
    BottomNavigationBarItem(
        icon: Image.asset('assets/icons/user_icon.png', width: 25),
        title: Container()),
    BottomNavigationBarItem(
        icon: Image.asset('assets/icons/family_icon.png',
            width: 25, color: Colors.white),
        title: Container()),
    BottomNavigationBarItem(
        icon: Image.asset('assets/icons/about_code_for_Iraq.png', width: 25),
        title: Container()),
    BottomNavigationBarItem(
        icon: Image.asset('assets/icons/about_app.png', width: 25),
        title: Container()),
  ];

  List<BottomNavigationBarItem> getItems() {
    switch (userType) {
      case UserType.admin:
        return adminItems;
        break;
      case UserType.family:
        return familyItems;
        break;

      default:
        return orgItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromRGBO(35, 68, 199, 1),
        items: getItems(),
        currentIndex: currentIndex,
        onTap: onSelectedTap,
      ),
    );
  }
}
