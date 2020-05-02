import 'package:attayairaq/models/organization.dart';
import 'package:attayairaq/services/data_base.dart';
import 'package:attayairaq/services/shered_Preference.dart';

Future<void> deleteOrganization(String orgId) async {
  DatabaseService(orgId).deleteOrg();
  await Future.delayed(Duration(seconds: 1));
}

 Future<Organization> getOrganizationData() async {
    final user = await SharedPrefs().getUser();
    final orgDoc = await DatabaseService(user.uid).organizationDataSnap;
    final org = Organization.fromDocument(orgDoc, orgDoc.documentID);
    return org;
  }