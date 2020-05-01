import 'package:attayairaq/models/family.dart';
import 'package:attayairaq/services/data_base.dart';

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
