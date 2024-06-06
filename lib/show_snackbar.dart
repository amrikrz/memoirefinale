import 'package:flutter/material.dart';
import 'package:sportapplication/shared/colors.dart';

showSnackBa(context, String titre) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: pink,

    content: Text(titre,style: TextStyle(fontWeight: FontWeight.bold),)));
}
