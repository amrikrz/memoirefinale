import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController2 {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  _uploadProfileImageToStorage2(Uint8List image) async {
    Reference ref =
        _storage.ref().child('profileimageResponsable').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> signupUsers2(String nom, String telephone,
      String email, String motpasse, Uint8List? image,String location) async {
    String res = 'succes';

    try {
      if (nom.isNotEmpty &&
          telephone.isNotEmpty &&
          email.isNotEmpty && // Check if email is not empty
          motpasse.isNotEmpty &&
          location.isNotEmpty&&
          image != null) {
        // Create a user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: motpasse);

        String profileImageUrl = await _uploadProfileImageToStorage2(image);
        //res = 'succès';

        await _firestore.collection('Responsables').doc(cred.user!.uid).set({
          'email': email,
          'fullname': nom,
          'phoneNumber': telephone,
          'acheyeurId': cred.user!.uid,
          'profileImage': profileImageUrl,
          "location":location
        });
      } else {
        res = 'les champs ne peuvent pas être vides'; // Provide an appropriate message for empty fields
      }
    } catch (e) {
        debugPrint("error : $e");
        res ='une erreur s\'est produite'; // Handle the error case and assign an appropriate message
    }
    return res;
  }

  loginUsers2(String email, String password) async {
    String res = 'quelque chose s\'est mal passé';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', FirebaseAuth.instance.currentUser!.uid);
        await prefs.setString('role', "coach");
        res = 'succès';
      } else {
        res = 'les champs ne peuvent pas être vides';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
  Future<void> saveUserLoginState2(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  Future<String?> getUserLoginState2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  pickProfileImage2(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('no image selected');
    }
  }
}
