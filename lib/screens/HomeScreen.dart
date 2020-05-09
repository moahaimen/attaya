import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:attayairaq/consts/consts.dart';
import 'package:attayairaq/consts/costume_nav_bar.dart';
import 'package:attayairaq/consts/loading.dart';
import 'package:attayairaq/models/family.dart';
import 'package:attayairaq/models/organization.dart';
import 'package:attayairaq/models/user.dart';
import 'package:attayairaq/screens/admin/control_panel.dart';
import 'package:attayairaq/screens/family/family_account.dart';
import 'package:attayairaq/screens/shared/map_screen.dart';
import 'package:attayairaq/services/data_base.dart';

enum UserType { admin, organisation, family, unKnown }

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({this.user});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            if (widget.user.userType == UserType.admin) {
              return AdminHomeScreen();
            } else if (widget.user.userType == UserType.organisation) {
              return OrganizationHomeScreen(user: widget.user);
            } else if (widget.user.userType == UserType.family) {
              return FamilyHomeScreen(user: widget.user);
            }

            return Loading();
          },
        );
      },
    );
  }
}

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('لوحة التحكم', context, isNotsubScreen: true),
      body: ControlPanel(),
      bottomNavigationBar: AdminNavBar(),
    );
  }
}

class OrganizationHomeScreen extends StatelessWidget {
  final User user;

  const OrganizationHomeScreen({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Organization>.value(
      value: DatabaseService(user.uid).organizatioData,
      child: Scaffold(
        appBar: apBar('الخريطة', context, isNotsubScreen: true),
        body: MapScreen(
          isNotSupScreen: true,
          isSelectLocation: false,
          isOrg: true,
        ),
        bottomNavigationBar: OrganizationNavBar(),
      ),
    );
  }
}

class FamilyHomeScreen extends StatelessWidget {
  final User user;
  const FamilyHomeScreen({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('حساب العائلة', context, isNotsubScreen: true),
      body: StreamProvider<Family>.value(
        value: DatabaseService(user.uid).familyData,
        child: FamilyAccount(),
      ),
      bottomNavigationBar: FamilyNavBar(),
    );
  }
}
