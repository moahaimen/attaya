import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/family.dart';
import '../services/data_base.dart';


Future<void> changeFamilyState(Family family) async {
  if(await connected()) {
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
  }else{
      throw('عذرا، حدث خطا غير معروف');

  }
}

Stream<List<Family>> getFamilies({String name}) {
  
  final data = Firestore.instance.collection("families")
  .where('family_name', isEqualTo: name);
  return data.snapshots().map((snaps) {
    return snaps.documents.map((doc) {
      return Family.fromDocument(doc, doc.documentID);
    }).toList();
  });
}
