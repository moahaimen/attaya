import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/request.dart';
import '../services/data_base.dart';

CollectionReference requestsCollection =
    Firestore.instance.collection('requests');

  ///to delete the request from the list by Admin
Future<void> deleteRequest(String requestId) async {
  await requestsCollection.document(requestId).delete();
}

  ///request to Add Family by Organization
Future<void> requestAddFamily(Request request) async {
  if (await connected()) {
    await requestsCollection.document(request.id).setData({
      'org_that_requested': request.orgThatRequested,
      'the_Family': {
        'id': request.theFamily.id,
        'family_name': request.theFamily.headOfFamily,
        'nearest_known_point': request.theFamily.nearestKnownPoint,
        'location': {
          'longitude': request.theFamily.location.longitude,
          'latitude': request.theFamily.location.latitude,
        },
        'phone_number': request.theFamily.phoneNo,
        'city': request.theFamily.city,
        'time_stamp': request.theFamily.timeStamp.toIso8601String(),
        'is_need_help': request.theFamily.isNeedHelp,
        'no_of_members': request.theFamily.noOfMembers,
        'province': request.theFamily.province,
      },
      'delete_reason': request.deleteReason,
      'is_delete_request': request.isDeleteRequest,
    });
  } else {
    throw ('عذرا، حدث خطا غير معروف');
  }
}

  ///request to delete Family by Organization
Future<void> sendDeleteRequestByOrg({Request request}) async {
  if (await connected()) {
    await requestsCollection.document(request.id).setData({
      'org_that_requested': request.orgThatRequested,
      'the_Family': {
        'id': request.theFamily.id,
        'family_name': request.theFamily.headOfFamily,
        'nearest_known_point': request.theFamily.nearestKnownPoint,
        'location': {
          'longitude': request.theFamily.location.longitude,
          'latitude': request.theFamily.location.latitude,
        },
        'phone_number': request.theFamily.phoneNo,
        'city': request.theFamily.city,
        'time_stamp': request.theFamily.timeStamp.toIso8601String(),
        'is_need_help': request.theFamily.isNeedHelp,
        'no_of_members': request.theFamily.noOfMembers,
        'province': request.theFamily.province,
      },
      'delete_reason': request.deleteReason,
      'is_delete_request': request.isDeleteRequest,
    });
  } else {
    throw ('عذرا، حدث خطا غير معروف');
  }
}
