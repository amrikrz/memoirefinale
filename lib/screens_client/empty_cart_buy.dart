import 'package:flutter/material.dart';

class EmptyCartWidget extends StatelessWidget {
  final VoidCallback onButtonPressed;

  const EmptyCartWidget({required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.shopping_cart_outlined,
          size: 100,
          color: Colors.grey,
        ),
        SizedBox(height: 20),
        Text(
          'La carte est vide',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextButton(
            onPressed: onButtonPressed,
            child: Text(
              'Continuer à acheter',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}