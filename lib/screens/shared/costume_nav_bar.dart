import 'package:flutter/material.dart';

import '../../functions/check_location_permission.dart';
import '../../screens/family/families._list.dart';
import '../../screens/orignization/organisations_list.dart';
import '../../screens/orignization/organization_account.dart';
import '../../screens/shared/map_screen.dart';
import '../../services/shered_Preference.dart';
import './about.dart';

class AdminNavBar extends StatelessWidget {
  const AdminNavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      color: const Color.fromRGBO(35, 68, 199, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          NavBarIcon(
            imageIcon: 'assets/icons/family_icon.png',
            route: const FamiliesList(isAdmin: true),
          ),
          IconButton(
            icon: Image.asset(
              'assets/icons/map_pin_1.png',
              width: 25,
              color: Colors.white,
            ),
            onPressed: () {
              checkLocationPermision(
                navigateToMap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const MapScreen(),
                  ),
                ),
              );
            },
          ),
          NavBarIcon(
            imageIcon: 'assets/icons/organization_icon.png',
            route: const OrganizationsList(isAdmin: true),
          ),
          NavBarIcon(
            imageIcon: 'assets/icons/about_code_for_Iraq.png',
            route: const About(isAboutApp: false, fromNavBar: true),
            color: null,
          ),
          NavBarIcon(
            imageIcon: 'assets/icons/about_app.png',
            route: const About(isAboutApp: true, fromNavBar: true),
          ),
        ],
      ),
    );
  }
}

class FamilyNavBar extends StatelessWidget {
  const FamilyNavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      color: const Color.fromRGBO(35, 68, 199, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          NavBarIcon(
            imageIcon: 'assets/icons/user_icon.png',
            route: null,
          ),
          NavBarIcon(
            imageIcon: 'assets/icons/organization_icon.png',
            route: const OrganizationsList(isAdmin: false),
          ),
          NavBarIcon(
            imageIcon: 'assets/icons/about_code_for_Iraq.png',
            route: const About(isAboutApp: false, fromNavBar: true),
            color: null,
          ),
          NavBarIcon(
            imageIcon: 'assets/icons/about_app.png',
            route: const About(isAboutApp: true, fromNavBar: true),
          ),
        ],
      ),
    );
  }
}

class OrganizationNavBar extends StatelessWidget {
  const OrganizationNavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      color: const Color.fromRGBO(35, 68, 199, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Image.asset(
              'assets/icons/user_icon.png',
              width: 25,
              color: Colors.white,
            ),
            onPressed: () async {
              final user = await SharedPrefs().getUser();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => OrganizationAccount(uid: user.uid),
                ),
              );
            },
          ),
          NavBarIcon(
            imageIcon: 'assets/icons/family_icon.png',
            route: const FamiliesList(isAdmin: false),
          ),
          NavBarIcon(
            imageIcon: 'assets/icons/about_code_for_Iraq.png',
            route: const About(isAboutApp: false, fromNavBar: true),
            color: null,
          ),
          NavBarIcon(
            imageIcon: 'assets/icons/about_app.png',
            route: const About(isAboutApp: true, fromNavBar: true),
          ),
        ],
      ),
    );
  }
}

class NavBarIcon extends StatelessWidget {
  final String imageIcon;
  final Color color;
  final Widget route;
  NavBarIcon({
    Key key,
    this.imageIcon,
    this.color = Colors.white,
    this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        imageIcon,
        width: 25,
        color: color,
      ),
      onPressed: route == null
          ? null
          : () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => route,
                ),
              );
            },
    );
  }
}
