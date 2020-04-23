
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreOperations {
  final databaseReference = Firestore.instance;

  createFamilyRecord(Map family) async {

    // for check if this family already exist 
    final a = await databaseReference
        .collection("families")
        .where('family_name', isEqualTo: family['family_name'])
        .where('phone', isEqualTo: family['phone']);

      print('data recievd ');
    final length = await a.getDocuments();

    //if this family not  exist so length of documents is 0 then add this famliy 
    if (length.documents.length == 0) {
      DocumentReference ref =
          await databaseReference.collection("families").add(family);
      return 'registred with succefully';
    } else {
      return 'this family already registered (number phone or family already exist)';
    }
 
 
  }

  void getData() {
    databaseReference
        .collection("families")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  void getDataById(String id) {
    databaseReference
        .collection("families")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  void updateData(String id, Map family) {
    try {
      databaseReference
          .collection('families')
          .document('id')
          .updateData(family);
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteData(String id) {
    try {
      databaseReference.collection('families').document(id).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
