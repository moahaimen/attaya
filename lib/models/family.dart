import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:attayairaq/models/location.dart';

class Family {
  final String id; //1
  final String headOfFamily; //2
  final String province; //5
  final String city; //6
  final String phoneNo; //7
  final Location location;
  final DateTime timeStamp; //10
  final bool isNeedHelp;
  final bool isApprovedFromAdmin;
  final int noOffamilyMembers;
  final String nearestKnownPoint;

  Family({
    @required this.id,
    @required this.headOfFamily,
    @required this.province,
    @required this.city,
    @required this.phoneNo,
    @required this.location,
    @required this.timeStamp,
    @required this.isNeedHelp,
    @required this.isApprovedFromAdmin,
    @required this.noOffamilyMembers,
    @required this.nearestKnownPoint,
  });

  factory Family.fromDocument(DocumentSnapshot doc) {
    return Family(
      id: doc.data['id'],
      headOfFamily: doc.data['head_of_family'],
      province: doc.data['province'],
      city: doc.data['city'],
      phoneNo: doc.data['phone_no'],
      timeStamp: doc.data['time_stamp'],
      isNeedHelp: doc.data['is_need_help'],
      nearestKnownPoint: doc.data['nearest_known_point'],
      noOffamilyMembers: doc.data['no_of_family_members'],
      isApprovedFromAdmin: doc.data['is_approved_from_admin'],
      location: Location(
        longitude: doc.data['longitude'],
        latitude: doc.data['latitude'],
      ),
    );
  }
}
