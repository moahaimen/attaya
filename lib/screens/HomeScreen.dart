import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import './shared/about.dart';
import '../models/family.dart';
import '../consts/loading.dart';
import '../services/data_base.dart';
import '../models/organization.dart';
import './family/families._list.dart';
import './shared/costume_nav_bar.dart';
import '../screens/shared/map_screen.dart';
import '../services/shered_Preference.dart';
import '../screens/admin/control_panel.dart';
import '../screens/family/family_account.dart';
import './orignization/organisations_list.dart';
import './orignization/organization_account.dart';

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

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final List<Widget> pages = [
    const ControlPanel(hasLoginIcon: true),
    const FamiliesList(isAdmin: true, isNotsubScreen: true),
    const MapScreen(),
    const OrganizationsList(isAdmin: true, isNotsubScreen: true),
    const About(isAboutApp: false, fromNavBar: true),
    const About(isAboutApp: true, fromNavBar: true),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CustomNavBar(
        currentIndex: currentIndex,
        userType: UserType.admin,
        onSelectedTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
      ),
    );
  }
}

class OrganizationHomeScreen extends StatefulWidget {
  final User user;

  const OrganizationHomeScreen({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _OrganizationHomeScreenState createState() => _OrganizationHomeScreenState();
}

class _OrganizationHomeScreenState extends State<OrganizationHomeScreen> {
  final List<Widget> pages = [
    const MapScreen(isOrg: true, hasLoginIcon: true),
    const OrganizationAccount(),
    const FamiliesList(isAdmin: false, isNotsubScreen: true),
    const About(isAboutApp: false, fromNavBar: true),
    const About(isAboutApp: true, fromNavBar: true),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamProvider<Organization>.value(
        value: DatabaseService(widget.user.uid).organizatioData,
        child: pages[currentIndex],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: currentIndex,
        userType: UserType.organisation,
        onSelectedTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
      ),
    );
  }
}

class FamilyHomeScreen extends StatefulWidget {
  final User user;
  const FamilyHomeScreen({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _FamilyHomeScreenState createState() => _FamilyHomeScreenState();
}

class _FamilyHomeScreenState extends State<FamilyHomeScreen> {
  final List<Widget> pages = [
    const FamilyAccount(hasLoginIcon: true),
    const OrganizationsList(isAdmin: false, isNotsubScreen: true),
    const About(isAboutApp: false, fromNavBar: true),
    const About(isAboutApp: true, fromNavBar: true),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamProvider<Family>.value(
        value: DatabaseService(widget.user.uid).familyData,
        child: pages[currentIndex],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: currentIndex,
        userType: UserType.family,
        onSelectedTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
      ),
    );
  }
}
