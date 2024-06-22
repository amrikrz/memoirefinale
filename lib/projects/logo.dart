import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/coach/main_coach_screen.dart';
import 'package:sportapplication/projects/image3.dart';
import 'package:sportapplication/screens_client/home_client2.dart';
import 'package:sportapplication/screens_salle/home_salle2.dart';

import 'home_client.dart';

class MyLogo extends StatefulWidget {
  const MyLogo({super.key});

  @override
  State<MyLogo> createState() => _MyLogoState();
}

class _MyLogoState extends State<MyLogo> {

  @override
  void initState() {
    // TODO: implement initState
    UserLoged();
    super.initState();
  }

  Future<void> UserLoged() async{

    await Future.delayed(Duration(seconds: 2));

    if(FirebaseAuth.instance.currentUser != null){


      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? id =  prefs.getString('userId');
      String? role =  prefs.getString('role');

      if(role != null && role == "user"){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
               ClientHome()), // Replace NextPage with your actual next page widget
        );
      }else if(role != null && role == "coach"){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
               MainCoachScreen()), // Replace NextPage with your actual next page widget
        );
      }else if(role !=null && role == "sale"){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const ResponsableHome()), // Replace NextPage with your actual next page widget
        );
      }else{
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (context) =>
              const ImagesThree()), // Replace NextPage with your actual next page widget
        );
      }
    }else{
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) =>
            const ImagesThree()), // Replace NextPage with your actual next page widget
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Delay navigation by 5 seconds


    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/back_.png"),
                  ),
                ),
              ),
              Center(
                child: Image.asset(
                  "assets/icons/logo.png",
                  width: 800,
                  height: 800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}