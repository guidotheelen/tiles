import 'package:flutter/material.dart';

class RoundedCornerShape extends StatelessWidget {
  static const size = 20.0;

  final Color color;
  final List<Corner> corners;

  const RoundedCornerShape({
    Key? key,
    required this.color,
    required this.corners,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: corners.contains(Corner.topLeft)
              ? const Radius.circular(size)
              : Radius.zero,
          topRight: corners.contains(Corner.topRight)
              ? const Radius.circular(size)
              : Radius.zero,
          bottomLeft: corners.contains(Corner.bottomLeft)
              ? const Radius.circular(size)
              : Radius.zero,
          bottomRight: corners.contains(Corner.bottomRight)
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
}
