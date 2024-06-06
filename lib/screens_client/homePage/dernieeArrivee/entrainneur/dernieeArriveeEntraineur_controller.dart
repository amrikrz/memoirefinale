import 'package:cloud_firestore/cloud_firestore.dart';

class DernieearriveeController {
  Stream<QuerySnapshot> DernieeArrive() {
    return FirebaseFirestore.instance.collection('Entraineurs').where('accverified',isEqualTo: true,).snapshots();
  }
}
