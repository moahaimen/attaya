 
import 'package:attayairaq/screens/SignInorSignUp/HomeScreen.dart';
import 'package:attayairaq/services/shared_preferences.dart';
import 'package:attayairaq/screens/SignInorSignUp/signIn.dart'; 
import 'package:flutter/material.dart';
 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final a = await SharedPreferencesOperations().getUser();

    if (a == null) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ));
  } else {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ));
  }  
}
