import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class categorie extends StatefulWidget {
  const categorie({super.key});

  @override
  State<categorie> createState() => _categorieState();
}

class _categorieState extends State<categorie> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.pink.shade200,
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Choisir une catégorie',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
