import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../models/family.dart';
import '../consts/consts.dart';
import '../consts/loading.dart';
import '../services/data_base.dart';
import '../models/organization.dart';
import '../consts/costume_nav_bar.dart';
import '../screens/shared/map_screen.dart';
import '../services/shered_Preference.dart';
import '../screens/admin/control_panel.dart';
import '../screens/family/family_account.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: SharedPrefs().getUser(),
      builder: (context, snapshot) {
        var user = snapshot.data;
        return LayoutBuilder(
          builder: (context, constraints) {
            return OrientationBuilder(
              builder: (context, orientation) {
                if (user == null) return const Loading();
                if (user.userType == UserType.admin) {
                  return const AdminHomeScreen();
                } else if (user.userType == UserType.organisation) {
                  return OrganizationHomeScreen(user: user);
                } else if (user.userType == UserType.family) {
                  return FamilyHomeScreen(user: user);
                }

                return const Loading();
              },
            );
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
      body: const ControlPanel(),
      bottomNavigationBar: const AdminNavBar(),
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
        body: const MapScreen(isOrg: true),
        bottomNavigationBar: const OrganizationNavBar(),
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
      bottomNavigationBar: const FamilyNavBar(),
    );
  }
}
