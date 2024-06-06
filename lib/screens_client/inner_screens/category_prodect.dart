import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String productId,
      productTitle,
      productLevel,
      productPrice,
      productCategory,
      productMaterial,
      productCoachName,
      productDescription,
      productTime,
      productImage,
      productQuntity;

  ProductModel(
      {required this.productId,
      required this.productTitle,
      required this.productLevel,
      required this.productPrice,
      required this.productCategory,
      required this.productMaterial,
      required this.productCoachName,
      required this.productDescription,
      required this.productTime,
      required this.productImage,
      required this.productQuntity, required String productVideo});
}
