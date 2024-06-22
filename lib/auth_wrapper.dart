import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/coach/RegisterApresSignup/EntraineurRegistreScreen.dart';
import 'package:sportapplication/projects/home_client.dart';
import 'package:sportapplication/projects/logo.dart';
import 'package:sportapplication/screens_salle/home_salle2.dart';


class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading indicator if Firebase Auth is still initializing
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            // If a user is authenticated, return the appropriate home page based on their role
            final user = snapshot.data!;
            return getHomePage(user);
          } else {
            // If no user is authenticated, show the login page
            return MyLogo();
          }
        }
      },
    );
  }

  Widget getHomePage(User user) {
    String role = 'client';

    
    switch (role) {
      case 'client':
        return ClientHome();
      case 'coach':
        return CoachRegistrationScreen();
      case 'resonsable':
        return ResponsableHome();
      default:
        return MyLogo();
    }
  }
}