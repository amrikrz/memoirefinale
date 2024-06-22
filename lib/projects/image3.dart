import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'what_you_are.dart';

class ImagesThree extends StatelessWidget {
  const ImagesThree({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> imagePaths = [
      {
        "path": "assets/images/image1.png",
        "text": "Votre compagnon de fitness personnel",
      },
      {
        "path": "assets/images/image2 .png",
        "text": "Entraînez-vous n'importe où, n'importe quand",
      },
      {
        "path": "assets/images/image3.png",
        "text": "Informations sur les progrès",
      },
      // Add more image paths as needed
    ];

    return SafeArea(
      child: Scaffold(
      
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 130,),
              CarouselSlider.builder(
                itemCount: imagePaths.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return Card(
                    elevation:
                        0, // Set elevation to 0 to remove the yellow overlay
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          imagePaths[itemIndex]['path']!,
                          fit: BoxFit.cover, // Adjust the image size
                          height: 260, // Adjust the image height
                        ),
                        const SizedBox(height: 10),
                        Text(
                          imagePaths[itemIndex]['text']!,
                          textAlign: TextAlign.center, // Center the text
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 400,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {},
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(height: 0),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50),
                child: ElevatedButton(
                  onPressed: () {
                            Navigator.pushAndRemoveUntil(context,CupertinoPageRoute(builder: (context)=>ChoisirWhatYouAre()),(route)=>false);

                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(233, 61, 73, 1)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 110, vertical: 14)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )),
                  child: const Text(
                    "Commencer",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}