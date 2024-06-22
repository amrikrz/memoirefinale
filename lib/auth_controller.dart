import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  _uploadProfileImageToStorage(Uint8List image) async {
    Reference ref =
        _storage.ref().child('profileimage').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> signupUsers(String fullnom, String telephone, String DateNaiss,
      String email, String password, Uint8List? image, String gendre) async {
    String res = 'succes';

    try {
      if (fullnom.isNotEmpty &&
          telephone.isNotEmpty &&
          DateNaiss.isNotEmpty && 
          email.isNotEmpty && 
          password.isNotEmpty &&
          gendre.isNotEmpty &&
          image != null) {
      
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String profileImageUrl =
            await _uploadProfileImageToStorage(image);
        //res = 'succès';

        await _firestore.collection('Sportifs').doc(cred.user!.uid).set({
          'email': email,
          'fullname': fullnom,
          'phoneNumber': telephone,
          'acheyeurId': cred.user!.uid,
          "dateNaiss":DateNaiss ,
          'profileImage': profileImageUrl,
          'gendre': gendre,
        });
      } else {
        res =
            'les champs ne peuvent pas être vides'; 
      }
    } catch (e) {
    
    }
    return res;
  }

  loginUsers(String email, String password) async {
    String res = 'quelque chose s\'est mal passé';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = 'succès';
      } else {
        res = 'les champs ne peuvent pas être vides';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
  Future<void> saveUserLoginState(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('role', "user");
  }

  Future<List<String>?> getUserLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id =  await prefs.getString('userId');
    String? role =  await prefs.getString('role');

    return id==null ?[]:[id,role!];
  }

  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('no image selected');
    }
  }
}
