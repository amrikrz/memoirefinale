import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CoachController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> _uploadImageToStorage(Uint8List? image, String path) async {
    Reference ref = _storage.ref().child(path).child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<Uint8List?> pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    return _file != null ? await _file.readAsBytes() : null;
  }

  Future<String> uploadCoachImage(Uint8List? image) async {
    return await _uploadImageToStorage(image, 'coachImages');
  }

  Future<String> uploadCVImage(Uint8List? cv) async {
    return await _uploadImageToStorage(cv, 'cvImages');
  }

  Future<String> uploadCarteNationaleImage(Uint8List? carteNatio) async {
    return await _uploadImageToStorage(carteNatio, 'carteNationaleImages');
  }

  Future<String> registerCoach(
    String businessName,
    String email,
    String phoneNumber,
    String countryValue,
    String stateValue,
    String cityValue,
    
    Uint8List? image,
    Uint8List? cv,
    Uint8List? carteNatio,
  ) async {
    try {
      String storeImage = await uploadCoachImage(image);
      String storeCV = await uploadCVImage(cv);
      String storeCarteNationale = await uploadCarteNationaleImage(carteNatio);

      await _firestore.collection('Entraineurs').doc(_auth.currentUser!.uid).set({
        'businessName': businessName,
        'email': email,
        'phoneNumber': phoneNumber,
        'countryValue': countryValue,
        'stateValue': stateValue,
        'cityValue': cityValue,
        'cv': storeCV,
        'carteNationale': storeCarteNationale,
        'storeImage': storeImage,
        'accverified':true,
        'coachId': _auth.currentUser!.uid,
      });

      return 'success';
    } catch (e) {
      return e.toString();
    }
  }
}
