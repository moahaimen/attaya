import 'package:attayairaq/screens/admin/organisations_list.dart';
import 'package:attayairaq/screens/shared/families._list.dart';
import 'package:attayairaq/screens/shared/map_screen.dart';
import 'package:flutter/material.dart';

class AdminNavBar extends StatelessWidget {
  const AdminNavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      color: Color.fromRGBO(35, 68, 199, 1),
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
                  builder: (_) => FamiliesList(isAdmin: true),
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MapScreen(),
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
                  builder: (_) => OrganizationsList(
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
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      color: Color.fromRGBO(35, 68, 199, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Image.asset(
              'assets/icons/organization_icon.png',
              width: 25,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => OrganizationsList(
                    isAdmin: false,
                  ),
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MapScreen(isNotSupScreen: false,),
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
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      color: Color.fromRGBO(35, 68, 199, 1),
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
                  builder: (_) => FamiliesList(isAdmin: false),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
