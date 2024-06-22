import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class PlanObject{
  String name,description,niveau,categorie,prix,image,uid;


  PlanObject(
      {required this.name,required this.description,required this.niveau,required this.categorie,required this.prix,required this.image,required this.uid});
}