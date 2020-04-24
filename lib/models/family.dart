import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyModel {
  String id; //1
  String firstName; //2
  String lastName; //3
  String familyName; //4
  String province; //5
  String city; //6
  String phoneNo; //7
  String geolocation; //8
  String password; //9
  String timeStamp; //10

  FamilyModel({
    this.id,
    this.firstName,
    this.lastName,
    this.familyName,
    this.province,
    this.city,
    this.geolocation,
    this.password,
    this.phoneNo,
    this.timeStamp,
  });

  factory FamilyModel.fromDocument(DocumentSnapshot doc) {
    return FamilyModel(
      id: doc['id'],
      firstName: doc['first_name'],
      lastName: doc['last_name'],
      familyName: doc['family_name'],
      province: doc['province'],
      city: doc['city'],
      password: doc['passowrd'],
      geolocation: doc['geolocation'],
      phoneNo: doc['phone_no'],
      timeStamp: doc['timeStamp'],
    );
  }
}
