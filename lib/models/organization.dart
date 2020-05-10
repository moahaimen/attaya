import 'package:cloud_firestore/cloud_firestore.dart';

import './location.dart';
class Organization {
  final String id;
  final String name;
  final String phoneNumber;
  final String province;
  final String distributionArea;
  final String managerName;
  final String managerPhoneNo;
  final Location location;
  final String description;

  Organization({
    this.id,
    this.name,
    this.phoneNumber,
    this.province,
    this.distributionArea,
    this.managerName,
    this.managerPhoneNo,
    this.location,
    this.description,
  });

  factory Organization.fromDocument(DocumentSnapshot doc, String id) {
    final Map location = doc.data['location'];
    return Organization(
      id: id,
      name: doc.data['name'],
      province: doc.data['province'],
      distributionArea: doc.data['distribution_area'],
      phoneNumber: doc.data['phone_number'],
      description: doc.data['description'],
      managerName: doc.data['manager_name'],
      managerPhoneNo: doc.data['manager_phone_no'],
      location: Location(
        longitude: double.parse( location['longitude'].toString()),
        latitude:double.parse( location['latitude'].toString()),
      ),
    );
  }
}
