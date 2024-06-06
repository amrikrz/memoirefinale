import 'package:flutter/material.dart';
import 'package:sportapplication/screens_client/cart/cart_shop.dart';
import 'package:sportapplication/screens_client/empty_cart_buy.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CartPage(),
    );
  }
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isCartEmpty = false; // Set to false initially to show ShopCartWidget first

  void addItemToCart() {
    setState(() {
      isCartEmpty = false;
    });
  }

  void emptyCart() {
    setState(() {
      isCartEmpty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: isCartEmpty
          ? EmptyCartWidget(
              onButtonPressed: addItemToCart,
            )
          : ShopCartWidget(),
      ),
    );
  }
}
