import '../services/data_base.dart';
import '../models/organization.dart';
import '../services/shered_Preference.dart';

Future<void> deleteOrganization(String orgId) async {
  DatabaseService(orgId).deleteOrg();
}

 Future<Organization> getOrganizationData() async {
    final user = await SharedPrefs().getUser();
    final orgDoc = await DatabaseService(user.uid).organizationDataSnap;
    final org = Organization.fromDocument(orgDoc, orgDoc.documentID);
    return org;
  }