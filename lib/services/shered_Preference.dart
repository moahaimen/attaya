import 'package:attayairaq/models/user.dart';
import 'package:attayairaq/screens/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<void> setUser(String phoneNo, String uid, String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', userType);
    await prefs.setString('phoneNo', phoneNo);
    await prefs.setString('uid', uid);
  }

  Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
