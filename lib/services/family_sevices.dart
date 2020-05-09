import 'package:attayairaq/models/family.dart';
import 'package:attayairaq/services/data_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteFamily(String familyId) async {
  await Future.delayed(Duration(seconds: 1));
  await DatabaseService(familyId).deleteFamily();
}

Future<void> changeFamilyState(Family family) async {
  await Future.delayed(Duration(seconds: 1));
  await DatabaseService(family.id).updateFamilyData(
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
}

Future<void> addFamily(Family family) async {
  await Future.delayed(Duration(seconds: 1));
  await DatabaseService(family.id).updateFamilyData(family);
}

Stream<List<Family>> getFamilies({bool isNeed, String name}) {
  final data = Firestore.instance.collection("families")
  .where('family_name', isEqualTo: name);

  // final familyData = await data.getDocuments();

  // print(familyData);
  return data.snapshots().map((snaps) {
    return snaps.documents.map((doc) {
      return Family.fromDocument(doc, doc.documentID);
    }).toList();
  });
}
