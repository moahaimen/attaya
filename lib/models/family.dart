import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Family_model {

  String id;//1
  String  first_name;//2
  String last_name;//3
  String family_name;//4
  String province;//5
  String city;//6
  String phone_no;//7
  String geolocation;//8
  String password;//9
  String timeStamp;//10

  Family_model({
    this.id,
    this.first_name,
    this.last_name,
    this.family_name,
    this.province,
    this.city,
    this.geolocation,
    this.password,
    this.phone_no,
    this.timeStamp
  });

factory Family_model.fromDocument(DocumentSnapshot doc){
  return Family_model(
    id :doc['id'],
    first_name: doc['first_name'],
    last_name: doc['last_name'],
    family_name: doc['family_name'],
    province: doc['province'],
    city: doc['city'],
    password: doc['passowrd'],
    geolocation: doc['geolocation'],
    phone_no: doc['phone_no'],
    timeStamp: doc['timeStamp'],



  );
}

}

