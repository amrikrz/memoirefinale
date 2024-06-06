import 'package:flutter/material.dart';
import 'package:sportapplication/projects/image3.dart';

class MyLogo extends StatelessWidget {
  const MyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    // Delay navigation by 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const ImagesThree()), // Replace NextPage with your actual next page widget
      );
    });

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