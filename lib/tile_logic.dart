import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:tiles/rounded_corner_shape.dart';
import 'package:tiles/triangle_shape.dart';

class TileLogic {
  final backgroundColor = const Color(0xFFe9dbba);
  final colorPalet = const [
    Color(0xFFDEA540),
    Color(0xFF306285),
    Color(0xFF447955),
    Color(0xFFA94230),
    Color(0xFF424242),
  ];

  final shapePalet = {
    Shape.roundedCornerTopLeft: const RoundedCornerShape(
        color: Colors.black54, corners: [Corner.topLeft]),
    Shape.roundedCornerTopRight: const RoundedCornerShape(
        color: Colors.black54, corners: [Corner.topRight]),
    Shape.roundedCornerBottomLeft: const RoundedCornerShape(
        color: Colors.black54, corners: [Corner.bottomLeft]),
    Shape.roundedCornerBottomRight: const RoundedCornerShape(
        color: Colors.black54, corners: [Corner.bottomRight]),
    Shape.roundedCornerAll: const RoundedCornerShape(
        color: Colors.black54,
        corners: [
          Corner.topLeft,
          Corner.topRight,
          Corner.bottomLeft,
          Corner.bottomRight
        ]),
    Shape.roundedCornerTopLeftBottomRight: const RoundedCornerShape(
        color: Colors.black54, corners: [Corner.topLeft, Corner.bottomRight]),
    Shape.roundedCornerTopRightBottomLeft: const RoundedCornerShape(
        color: Colors.black54, corners: [Corner.topRight, Corner.bottomLeft]),
    Shape.roundedCornerTopLeftBottomLeft: const RoundedCornerShape(
        color: Colors.black54, corners: [Corner.topLeft, Corner.bottomLeft]),
    Shape.roundedCornerTopRightBottomRight: const RoundedCornerShape(
        color: Colors.black54, corners: [Corner.topRight, Corner.bottomRight]),
    Shape.roundedCornerBottomLeftBottomRight: const RoundedCornerShape(
        color: Colors.black54,
        corners: [Corner.bottomLeft, Corner.bottomRight]),
    Shape.roundedCornerBottomLeftTopLeft: const RoundedCornerShape(
        color: Colors.black54, corners: [Corner.bottomLeft, Corner.topLeft]),
    Shape.triangleTopLeft:
        const TriangleShape(color: Colors.black54, corner: Corner.topLeft),
    Shape.triangleTopRight:
        const TriangleShape(color: Colors.black54, corner: Corner.topRight),
    Shape.triangleBottomLeft:
        const TriangleShape(color: Colors.black54, corner: Corner.bottomLeft),
    Shape.triangleBottomRight:
        const TriangleShape(color: Colors.black54, corner: Corner.bottomRight),
  };

  var currentShapes = [
    Shape.roundedCornerTopLeft,
    Shape.roundedCornerTopRight,
    Shape.roundedCornerBottomLeft,
    Shape.roundedCornerBottomRight,
    Shape.roundedCornerAll,
  ];

  var currentColors = [
    const Color(0xFFDEA540),
    const Color(0xFF306285),
  ];
  var horizontalTileCount = 3;
  var verticalTileCount = 3;
  var mirrorHorizontally = true;
  var mirrorVertically = true;

  switchMirrorHorizontally() => mirrorHorizontally = !mirrorHorizontally;

  switchMirrorVertically() => mirrorVertically = !mirrorVertically;

  switchShape(Shape shape) {
    if (currentShapes.contains(shape)) {
      currentShapes.remove(shape);
    } else {
      currentShapes.add(shape);
    }
  }

  List<Color> randomColorList(int count) => List.generate(
      count, (_) => currentColors[Random().nextInt(currentColors.length)]);

  List<int> randomNumberList(int count, int max) =>
      List.generate(count, (_) => Random().nextInt(max));
}

enum Shape {
  roundedCornerTopLeft,
  roundedCornerTopRight,
  roundedCornerBottomLeft,
  roundedCornerBottomRight,
  roundedCornerAll,
  roundedCornerTopLeftBottomRight,
  roundedCornerTopRightBottomLeft,
  roundedCornerTopLeftBottomLeft,
  roundedCornerTopRightBottomRight,
  roundedCornerBottomLeftBottomRight,
  roundedCornerBottomLeftTopLeft,
  triangleTopLeft,
  triangleTopRight,
  triangleBottomLeft,
  triangleBottomRight,
}

enum Corner {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}
