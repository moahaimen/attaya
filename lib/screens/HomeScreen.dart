import 'package:attayairaq/consts/consts.dart';
import 'package:attayairaq/consts/costume_nav_bar.dart';
import 'package:attayairaq/screens/admin/control_panel.dart';
import 'package:flutter/material.dart';

enum UserType {
  admin,
  organisation,
  family,
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserType _type = UserType.admin;

  @override
  Widget build(BuildContext context) {
    if (_type == UserType.admin) {
      return AdminHomeScreen();
    } else if (_type == UserType.organisation) {
      return Container();
    }

    return Container();
  }
}

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('لوحة التحكم', context, true),
      body: ControlPanel(),
      bottomNavigationBar: AdminNavBar(),
    );
  }
}
