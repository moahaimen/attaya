import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:attayairaq/models/family.dart';

class Request {
  final String id;
  final String orgThatRequested;
  final Family theFamily;
  final String deleteReason;
  final bool isDeleteRequest;

  Request({
    @required this.id,
    @required this.orgThatRequested,
    @required this.theFamily,
    @required this.deleteReason,
    @required this.isDeleteRequest,
  });

  factory Request.fromDocument(DocumentSnapshot doc, String id) {
    Map family = doc['the_Family'];
    return Request(
      id: id,
      orgThatRequested: doc['org_that_requested'],
      theFamily: Family(
        id: family['id'],
        headOfFamily: family['family_name'],
        province: family['province'],
        city: family['city'],
        phoneNo: family['phone_number'],
        timeStamp: null,
        isNeedHelp: family['is_need_help'],
        nearestKnownPoint: family['nearest_known_point'],
        noOfMembers: family['no_of_members'],
        location: null,
      ),
      deleteReason: doc['delete_reason'],
      isDeleteRequest: doc['is_delete_request'],
    );
  }
}
