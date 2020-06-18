import 'package:flutter/material.dart';

import '../../screens/shared/map_screen.dart';
import '../../services/shered_Preference.dart';
import '../../screens/family/families._list.dart';
import '../../functions/check_location_permission.dart';
import '../../screens/orignization/organisations_list.dart';
import '../../screens/orignization/organization_account.dart';

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
          IconButton(
            icon: Image.asset(
              'assets/icons/family_icon.png',
              width: 25,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const FamiliesList(isAdmin: true),
                ),
              );
            },
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
          IconButton(
            icon: Image.asset(
              'assets/icons/organization_icon.png',
              width: 25,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const OrganizationsList(
                    isAdmin: true,
                  ),
                ),
              );
            },
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
          IconButton(
              icon: Image.asset(
                'assets/icons/user_icon.png',
                width: 25,
                color: Colors.white,
              ),
              onPressed: null),
          IconButton(
            icon: Image.asset(
              'assets/icons/organization_icon.png',
              width: 25,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const OrganizationsList(
                    isAdmin: false,
                  ),
                ),
              );
            },
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
          IconButton(
            icon: Image.asset(
              'assets/icons/family_icon.png',
              width: 25,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const FamiliesList(isAdmin: false),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
