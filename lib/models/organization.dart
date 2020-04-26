import 'package:attayairaq/models/location.dart';

class Organization {
  final String id;
  final String name;
  final String phoneNumber;
  final String governorate;
  final String distributionArea;
  final String managerName;
  final String managerPhoneNo;
  final Location location;
  final String description;



  Organization({
    this.id,
    this.name,
    this.phoneNumber,
    this.governorate,
    this.distributionArea,
    this.managerName,
    this.managerPhoneNo,
    this.location,
    this.description,
  });
}
