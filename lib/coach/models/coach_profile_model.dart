import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoachProfileModel{
  String name,image,email,number,region,state,city;

  CoachProfileModel({
    required this.name,
    required this.image,
    required this.email,
    required this.number,
    required this.region,
    required this.state,
    required this.city,
  });


}