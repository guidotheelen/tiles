import 'package:flutter/material.dart';

class Shape extends StatelessWidget {
  final double size;
  final Color color;
  final Corner corner;

  const Shape({
    Key? key,
    required this.size,
    required this.color,
    required this.corner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: corner == Corner.topLeft || corner == Corner.all
              ? Radius.circular(size)
              : Radius.zero,
          topRight: corner == Corner.topRight || corner == Corner.all
              ? Radius.circular(size)
              : Radius.zero,
          bottomLeft: corner == Corner.bottomLeft || corner == Corner.all
              ? Radius.circular(size)
              : Radius.zero,
          bottomRight: corner == Corner.bottomRight || corner == Corner.all
              ? Radius.circular(size)
              : Radius.zero,
        ),
      ),
    );
  }
}

enum Corner {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  all,
}
