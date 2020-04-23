



import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesOperations{


  store_user(FirebaseUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('user', [
      user.uid.toString(),
      user.phoneNumber.toString(),

     ]);
  }

  get_user() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final list= await prefs.getStringList('user');

        return list;
   
   }


}
