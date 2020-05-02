
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
  final int noOfMembers;
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
    @required this.noOfMembers,
    @required this.nearestKnownPoint,
  });

  factory Family.fromDocument(DocumentSnapshot doc, String id) {
    final Map location = doc.data['location'];

    return Family(
      id: id,
      headOfFamily: doc.data['family_name'],
      province: doc.data['province'],
      city: doc.data['city'],
      phoneNo: doc.data['phone_number'],
      timeStamp: DateTime.parse(doc.data['time_stamp']),
      isNeedHelp: doc.data['is_need_help'],
      nearestKnownPoint: doc.data['nearest_known_point'],
      noOfMembers: doc.data['no_of_members'],
      location: Location(
        longitude: location['longitude'],
        latitude: location['latitude'],
      ),
    );
  }
}
