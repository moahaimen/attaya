import 'package:attayairaq/models/family.dart';
import 'package:attayairaq/models/organization.dart';
import 'package:attayairaq/models/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  Future updateFamilyData(Family family) async {
    //this can be used to add new family or update an exsisting one
    return await familiesCollection.document(uid).setData(
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
  }

  Future deleteFamily() async {
    //this can be used to add new family or update an exsisting one
    return await familiesCollection.document(uid).delete();
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

  Future updateOrganizationData(Organization organization) async {
    //this can be used to add new organization or update an exsisting one
    return await organizationsCollection.document(uid).setData(
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

  Stream<Organization> get organizatioData {
    return organizationsCollection
        .document(uid)
        .snapshots()
        .map(_organizationDataFromSnapshot);
  }
  Future deleteOrg() async {
    //this can be used to add new family or update an exsisting one
    return await organizationsCollection.document(uid).delete();
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
