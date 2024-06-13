import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PubliciteAccueil extends StatefulWidget {
  @override
  _PubliciteAccueilState createState() => _PubliciteAccueilState();
}

class _PubliciteAccueilState extends State<PubliciteAccueil> {
  Future<List<String>> getSliderIl() async {
    var _fireStore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await _fireStore.collection('publicité').get();
    // Récupérer les URLs des images dans une liste
    List<String> imageUrls = snapshot.docs.map((doc) {
      return doc['image'] as String;
    }).toList();
    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getSliderIl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error fetching images'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No images available'));
        }

        var imageUrls = snapshot.data!;
        return CarouselSlider.builder(
          itemCount: imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            String imageUrl = imageUrls[index % imageUrls.length];
            return Image.network(imageUrl, fit: BoxFit.cover);
          },
          options: CarouselOptions(
            autoPlayInterval: Duration(seconds: 5),
            initialPage: 0,
            autoPlay: true,
            
            height: 150,
            viewportFraction: 1.0,
            enlargeCenterPage: true,
          ),
        );
      },
    );
  }
}
