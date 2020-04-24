



import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesOperations{


  storeUser(FirebaseUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('user', [
      user.uid.toString(),
      user.phoneNumber.toString(),

     ]);
  }

  getUser() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final list= prefs.getStringList('user');

        return list;
   
   }


}
