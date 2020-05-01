import 'package:attayairaq/services/data_base.dart';

Future<void> deleteOrganization(String orgId) async {
  DatabaseService(orgId).deleteOrg();
  await Future.delayed(Duration(seconds: 1));
}
