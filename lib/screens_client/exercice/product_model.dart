import 'package:flutter/material.dart';

class ProductModel {
  final String productId;
  final String productTitle;
  final String productPrice;
  final String productCategory;
  final String productDescription;
  final String productImage;
  final String productCoachName;
  final String productLevel;
  final String productMaterial;
  final String productQuantity; // Corrected typo in field name
  final String productTime;
  final String productVideo; // Define productVideo field

  ProductModel({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productCategory,
    required this.productDescription,
    required this.productImage,
    required this.productCoachName,
    required this.productLevel,
    required this.productMaterial,
    required this.productQuantity,
    required this.productTime,
    required this.productVideo, // Include productVideo in constructor
  });
}
