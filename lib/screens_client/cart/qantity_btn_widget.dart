import 'package:flutter/material.dart';

class QuantityBottomSheetWidget extends StatelessWidget {
  const QuantityBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        return Center(
          child: GestureDetector(
            onTap: () {
              print("index ${ index+1}");
            },
            child: Text(
              "${index + 1}",
            ),
          ),
        );
      },
    );
  }
}
