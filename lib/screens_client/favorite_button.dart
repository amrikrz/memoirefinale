import 'package:flutter/material.dart';
import 'package:sportapplication/shared/colors.dart';

class HeartButtonWidget extends StatefulWidget {
  final double size;

  final Color colors;

  const HeartButtonWidget({
    super.key,
    this.size = 22,
    this.colors = Colors.transparent,
  });
  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.colors,
      ),
      child: IconButton(
        style: IconButton.styleFrom(
          shape: CircleBorder(),
        ),
        onPressed: () {},
        icon: Icon(
          Icons.favorite_border_rounded,
          size: widget.size,
          color: white,
        ),
      ),
    );
  }
}
