import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/coach/models/exercice_object.dart';

class AddPlanExerciceProvider extends ChangeNotifier{

  Future<List<ExerciceObject>> getData(pereUid) async{

    List<ExerciceObject> list = [];

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore.collection("plan").doc(pereUid).collection("planExercice").get();

    snapshot.docs.forEach((element){
        list.add(
          ExerciceObject(name: element["name"], subtitle: element["subtitle"], image: element["image"], uid: element.id, pereUid: pereUid)
        );
    });

    return list;
  }

  Future<void> addData(ExerciceObject exercice) async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String url = await uploadFile(exercice.image);

    Map<String,String> data = {
      "name":exercice.name,
      "subtitle":exercice.subtitle,
      "image":url,
    };

    await firebaseFirestore.collection("plan").doc(exercice.pereUid).collection("planExercice").add(data);

    notifyListeners();

  }

  Future<String> uploadFile(String path) async{
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final ref = firebaseStorage.ref().child("upload/ExercicePlan");

    TaskSnapshot taskSnapshot = await  ref.putFile(File(path)).whenComplete((){

    });
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

}