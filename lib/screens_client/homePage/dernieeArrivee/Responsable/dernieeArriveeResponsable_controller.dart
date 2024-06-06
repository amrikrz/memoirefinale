import 'package:cloud_firestore/cloud_firestore.dart';

class DernieearriveeResponsableController {
  Stream<QuerySnapshot> DernieeArriveResponsable() {
    return FirebaseFirestore.instance.collection('Responsables').snapshots();
  }
}
