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
    Shape.roundedCornerTopLeft: (Color color) =>
        RoundedCornerShape(color: color, corners: const [Corner.topLeft]),
    Shape.roundedCornerTopRight: (Color color) =>
        RoundedCornerShape(color: color, corners: const [Corner.topRight]),
    Shape.roundedCornerBottomLeft: (Color color) =>
        RoundedCornerShape(color: color, corners: const [Corner.bottomLeft]),
    Shape.roundedCornerBottomRight: (Color color) =>
        RoundedCornerShape(color: color, corners: const [Corner.bottomRight]),
    Shape.roundedCornerAll: (Color color) => RoundedCornerShape(
            color: color,
            corners: const [
              Corner.topLeft,
              Corner.topRight,
              Corner.bottomLeft,
              Corner.bottomRight
            ]),
    Shape.roundedCornerTopLeftBottomRight: (Color color) => RoundedCornerShape(
        color: color, corners: const [Corner.topLeft, Corner.bottomRight]),
    Shape.roundedCornerTopRightBottomLeft: (Color color) => RoundedCornerShape(
        color: color, corners: const [Corner.topRight, Corner.bottomLeft]),
    Shape.roundedCornerTopLeftBottomLeft: (Color color) => RoundedCornerShape(
        color: color, corners: const [Corner.topLeft, Corner.bottomLeft]),
    Shape.roundedCornerTopRightBottomRight: (Color color) => RoundedCornerShape(
        color: color, corners: const [Corner.topRight, Corner.bottomRight]),
    Shape.roundedCornerBottomLeftBottomRight: (Color color) =>
        RoundedCornerShape(
            color: color,
            corners: const [Corner.bottomLeft, Corner.bottomRight]),
    Shape.roundedCornerBottomLeftTopLeft: (Color color) => RoundedCornerShape(
        color: color, corners: const [Corner.bottomLeft, Corner.topLeft]),
    Shape.triangleTopLeft: (Color color) =>
        TriangleShape(color: color, corner: Corner.topLeft),
    Shape.triangleTopRight: (Color color) =>
        TriangleShape(color: color, corner: Corner.topRight),
    Shape.triangleBottomLeft: (Color color) =>
        TriangleShape(color: color, corner: Corner.bottomLeft),
    Shape.triangleBottomRight: (Color color) =>
        TriangleShape(color: color, corner: Corner.bottomRight),
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
