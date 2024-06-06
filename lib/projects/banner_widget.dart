import 'package:flutter/material.dart';
import 'package:sportapplication/shared/colors.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:140 ,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: pink,
      ),
    );
  }
}