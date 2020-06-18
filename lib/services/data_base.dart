import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../models/family.dart';
import '../consts/consts.dart';
import '../models/request.dart';
import '../models/organization.dart';
import '../services/shered_Preference.dart';

///this func. will show in-app notification if there is no internet
Future<void> showCostumeDatabaseErrorNotif(String title) async {
  await Future.delayed(const Duration(seconds: 1));
  BotToast.showNotification(
    title: (child) {
      return Text(
        title,
        textDirection: TextDirection.rtl,
        style: textStyle,
      );
    },
    subtitle: (child) {
      return Text(
        'ملاحظة: تاكد من اتصالك بالانترنت',
        textDirection: TextDirection.rtl,
        style: textStyle.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
      );
    },
    duration: const Duration(seconds: 3),
  );
  await Future.delayed(const Duration(seconds: 2));
}

Future<bool> connected() async {
  //This will check if there is an internet connection
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  }
  return true;
}

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  CollectionReference familiesCollection =
      Firestore.instance.collection('families');

  CollectionReference organizationsCollection =
      Firestore.instance.collection('organizations');

  CollectionReference requestsCollection =
      Firestore.instance.collection('requests');

// family functions
  ///this can be used to add new family or update an exsisting one
  Future updateFamilyData(Family family) async {
    if (await connected()) {
      await familiesCollection.document(uid).setData(
        {
          'family_name': family.headOfFamily,
          'nearest_known_point': family.nearestKnownPoint,
          'location': {
            'longitude': family.location.longitude,
            'latitude': family.location.latitude,
          },
          'phone_number': family.phoneNo,
          'city': family.city,
          'time_stamp': family.timeStamp.toIso8601String(),
          'is_need_help': family.isNeedHelp,
          'no_of_members': family.noOfMembers,
          'province': family.province,
        },
      );
    } else {
      throw ('عذرا، حدث خطا غير معروف');
    }
  }

  Future<void> changeFamilyState(Family family) async {
    if (await connected()) {
      await updateFamilyData(
        Family(
          id: family.id,
          headOfFamily: family.headOfFamily,
          province: family.province,
          city: family.city,
          phoneNo: family.phoneNo,
          location: family.location,
          timeStamp: family.timeStamp,
          isNeedHelp: !family.isNeedHelp,
          noOfMembers: family.noOfMembers,
          nearestKnownPoint: family.nearestKnownPoint,
        ),
      );
    } else {
      throw ('عذرا، حدث خطا غير معروف');
    }
  }

  ///this can be used to delete family and only can be used by the admin
  Future deleteFamily() async {
    if (await connected()) {
      await familiesCollection.document(uid).delete();
    } else {
      throw ('عذرا، حدث خطا غير معروف');
    }
  }

  List<Family> _familiesListFromSnapshot(QuerySnapshot snap) {
    return snap.documents.map((doc) {
      return Family.fromDocument(doc, doc.documentID);
    }).toList();
  }

  Family _familyDataFromSnapshot(DocumentSnapshot snapshot) {
    return Family.fromDocument(snapshot, uid);
  }

  Stream<List<Family>> get families {
    return familiesCollection.snapshots().map(_familiesListFromSnapshot);
  }

  Stream<Family> get familyData {
    return familiesCollection
        .document(uid)
        .snapshots()
        .map(_familyDataFromSnapshot);
  }

  //org function

  ///this can be used to add new organization or update an exsisting one
  Future updateOrganizationData(Organization organization) async {
    if (await connected()) {
      organizationsCollection.document(uid).setData(
        {
          'name': organization.name,
          'phone_number': organization.phoneNumber,
          'province': organization.province,
          'distribution_area': organization.distributionArea,
          'manager_name': organization.managerName,
          'manager_phone_no': organization.managerPhoneNo,
          'description': organization.description,
          'location': {
            'latitude': 100,
            'longitude': 200,
          },
        },
      );
    } else {
      throw ('عذرا، حدث خطا غير معروف');
    }
  }

  List<Organization> _organizationsListFromSnapshot(QuerySnapshot snap) {
    return snap.documents.map((doc) {
      return Organization.fromDocument(doc, doc.documentID);
    }).toList();
  }

  Organization _organizationDataFromSnapshot(DocumentSnapshot snapshot) {
    return Organization.fromDocument(snapshot, uid);
  }

  Stream<List<Organization>> get organizations {
    return organizationsCollection
        .snapshots()
        .map(_organizationsListFromSnapshot);
  }

  Future<DocumentSnapshot> get organizationDataSnap {
    return organizationsCollection.document(uid).get();
  }

  Stream<Organization> get organizatioData {
    return organizationsCollection
        .document(uid)
        .snapshots()
        .map(_organizationDataFromSnapshot);
  }

  Future<Organization> getOrganizationData() async {
    final user = await SharedPrefs().getUser();
    final orgDoc = await DatabaseService(user.uid).organizationDataSnap;
    final org = Organization.fromDocument(orgDoc, orgDoc.documentID);
    return org;
  }

  ///this can be used to delete organization and only can be used by the admin
  Future deleteOrg() async {
    if (await connected()) {
      await organizationsCollection.document(uid).delete();
    } else {
      throw ('عذرا، حدث خطا غير معروف');
    }
  }

  // request

  List<Request> _requestListFromSnapshot(QuerySnapshot snap) {
    return snap.documents.map((doc) {
      return Request.fromDocument(doc, doc.documentID);
    }).toList();
  }

  Stream<List<Request>> get requests {
    return requestsCollection.snapshots().map(_requestListFromSnapshot);
  }
}
