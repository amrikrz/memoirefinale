import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/coach/models/coach_user_models.dart';
import 'package:sportapplication/coach/main_coach_screen.dart';
import 'package:sportapplication/coach/RegisterApresSignup/EntraineurRegistreScreen.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference _coachsStream =
        FirebaseFirestore.instance.collection('Entraineurs');

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: _coachsStream.doc(_auth.currentUser?.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.data!.exists) {
            return CoachRegistrationScreen();
          }

          if (snapshot.hasData && snapshot.data!.data() != null) {
            final coachData = snapshot.data!.data()! as Map<String, dynamic>;
            final CoachUserModel coachUserModel =
                CoachUserModel.fromJson(coachData);

            if (coachUserModel.approved! == false) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                Navigator.pushAndRemoveUntil(
                  context,
                    MaterialPageRoute(
                      builder: (context) => MainCoachScreen(),
                    ),
                      (route) => false,
                );

              });
              return SizedBox.shrink();
            }
          }

          return MainCoachScreen();
        },
      ),
    );
  }
}
