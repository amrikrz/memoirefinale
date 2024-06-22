import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/screens_client/alimentation/recipe_details.dart';

class AddReccetteProvider extends ChangeNotifier{

  Future<List<RecipeModel>> getData(String planUid,String reccetteUid) async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    List<RecipeModel> list = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore.collection("plan").doc(planUid).collection("planReccete").doc(reccetteUid).collection("reccetes").get();

    debugPrint("data size ${snapshot.docs.length}");
    debugPrint("plan uid ${snapshot.docs.length}");

    snapshot.docs.forEach((element){
      list.add(
          RecipeModel(name: element["name"], image: element["image"], category: element["categorie"], duration: element["duration"], calories: element["calorie"], subtitle: element["subtitle"], reccetteUid: reccetteUid, pereUid: planUid, uid: element.id, reccette: element["reccette"])
      );
    });

    return list;
  }

  Future<void> addData(RecipeModel recipe) async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String url = await uploadFile(recipe.image);

    Map<String,String> data = {
      "name":recipe.name,
      "subtitle":recipe.subtitle,
      "image":url,
      "calorie":recipe.calories,
      "duration":recipe.duration,
      "reccette":recipe.reccette,
      "categorie":recipe.category
    };

    await firebaseFirestore.collection("plan").doc(recipe.pereUid).collection("planReccete").doc(recipe.reccetteUid).collection("reccetes").add(data);

    notifyListeners();
  }
  Future<String> uploadFile(String path) async{
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final ref = firebaseStorage.ref().child("upload/ReccettePlan");

    TaskSnapshot taskSnapshot = await  ref.putFile(File(path)).whenComplete((){

    });
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }


}