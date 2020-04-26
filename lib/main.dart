import 'package:attayairaq/screens/HomeScreen.dart';
import 'package:attayairaq/services/shared_preferences.dart';
import 'package:attayairaq/screens/SignInorSignUp/signIn.dart';
import 'package:attayairaq/services/size_config.dart';
import 'package:flutter/material.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final a = 'await SharedPreferencesOperations().getUser()';

  if (a == null) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ));
  } else {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              SizeConfig().init(context);
              return HomeScreen();
            },
          );
        },
      ),
    ));
  }
}
