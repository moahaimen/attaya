import 'package:attayairaq/models/request.dart';
import 'package:attayairaq/models/user.dart';
import 'package:attayairaq/services/shered_Preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference requestsCollection =
    Firestore.instance.collection('requests');

Future<void> deleteRequest(String requestId) async {
  //delete the request from the list by Admin
  await requestsCollection.document(requestId).delete();
}

Future<void> requestAddFamily(Request request) async {
  //request to Add Family by Organization
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
}

Future<void> sendDeleteRequestByOrg({Request request}) async {
  //request to delete Family by Organization
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
}
