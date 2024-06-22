
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/exercice_object.dart';

class AddExerciceProvider extends ChangeNotifier{

  Future<List<ExerciceObject>> data(String planUid,String exerciceUid) async{
    
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> mdata = await firebaseFirestore.collection("plan").doc(planUid).collection("planExercice").doc(exerciceUid).collection("exercices").get();
    List<QueryDocumentSnapshot> gets = mdata.docs;

    List<ExerciceObject> list = [];

    for (var element in gets) {
        String idc = element.id;

        String name = element["name"];

        String subtitle = element["subtitle"];

        String image = element["image"];

        String pereUid = "";


        list.add(ExerciceObject(name: name, subtitle: subtitle, image: image, uid: idc,pereUid: pereUid));

    }


    return list;
  }

  Future<String> uploadFile(String path) async{
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final ref = firebaseStorage.ref().child("upload/plan");

    TaskSnapshot taskSnapshot = await  ref.putFile(File(path)).whenComplete((){

    });
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }


  Future<void> addData(ExerciceObject exercice) async{

    String link = await uploadFile(exercice.image);

    Map<String,dynamic> data = {
      "name":exercice.name,
      "subtitle":exercice.subtitle,
      "image":exercice.image
    };

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection("plan").doc(exercice.pereUid).collection("planExercice").doc(exercice.uid).collection("exercices").add(data);

    notifyListeners();
  }

}