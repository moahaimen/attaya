import 'package:attayairaq/screens/HomeScreen.dart';
import 'package:attayairaq/screens/authenticate.dart';
import 'package:attayairaq/services/shered_Preference.dart';
import 'package:attayairaq/wrapper.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final user = await SharedPrefs().getUser();
  user == null
      ? runApp(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            home: Wrapper(child: Authenticate()),
          ),
        )
      : runApp(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            home: Wrapper(
              child: HomeScreen(user: user),
            ),
          ),
        );
}
