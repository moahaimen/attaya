import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class SharedPrefs {
  Future<void> setUser(String phoneNo, String uid, String userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', userType);
    await prefs.setString('phoneNo', phoneNo);
    await prefs.setString('uid', uid);
  }

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userType = _findType(prefs.getString('userType'));
    final phoneNo = prefs.getString('phoneNo');
    final uid = prefs.getString('uid');
    return uid != null
        ? User(
            uid: uid,
            phoneNo: phoneNo,
            userType: userType,
          )
        : null;
  }

  UserType _findType(String userType) {
    switch (userType) {
      case 'admin':
        return UserType.admin;
        break;
      case 'family':
        return UserType.family;
        break;
      default:
        return UserType.organisation;
    }
  }

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
