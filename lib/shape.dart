import 'package:flutter/material.dart';

class Shape extends StatelessWidget {
  static const size = 20.0;

  final Color color;
  final Corner corner;

  const Shape({
    Key? key,
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
              ? const Radius.circular(size)
              : Radius.zero,
          topRight: corner == Corner.topRight || corner == Corner.all
              ? const Radius.circular(size)
              : Radius.zero,
          bottomLeft: corner == Corner.bottomLeft || corner == Corner.all
              ? const Radius.circular(size)
              : Radius.zero,
          bottomRight: corner == Corner.bottomRight || corner == Corner.all
              ? const Radius.circular(size)
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
