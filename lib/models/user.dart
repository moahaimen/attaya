import 'package:attayairaq/screens/HomeScreen.dart';

class User {
  final String uid;
  final String phoneNo;
  UserType userType;

  User({
    this.uid,
    this.phoneNo,
    this.userType,
  });

  @override
  String toString() => 'User(uid: $uid)';
}
