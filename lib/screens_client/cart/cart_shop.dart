import 'package:flutter/material.dart';
import 'package:sportapplication/screens_client/cart/cart_bottom_checkout.dart';
import 'package:sportapplication/screens_client/cart/cart_widget.dart';

class ShopCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete_forever_rounded,
              color: Colors.red,
            ),
          ),
        ],
        title: Text('Cart'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
        
        return const CartWidget();
      },
      ),
      bottomSheet: CartBottomChekout(),
    );
  }
}
