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

  final shapePalet = const [
    RoundedCornerShape(color: Colors.black54, corners: [Corner.topLeft]),
    RoundedCornerShape(color: Colors.black54, corners: [Corner.topRight]),
    RoundedCornerShape(color: Colors.black54, corners: [Corner.bottomLeft]),
    RoundedCornerShape(color: Colors.black54, corners: [Corner.bottomRight]),
    RoundedCornerShape(color: Colors.black54, corners: [
      Corner.topRight,
      Corner.bottomRight,
      Corner.topLeft,
      Corner.bottomLeft
    ]),
    RoundedCornerShape(
        color: Colors.black54, corners: [Corner.topLeft, Corner.bottomRight]),
    RoundedCornerShape(
        color: Colors.black54, corners: [Corner.topRight, Corner.bottomLeft]),
    RoundedCornerShape(
        color: Colors.black54, corners: [Corner.topLeft, Corner.bottomLeft]),
    RoundedCornerShape(
        color: Colors.black54, corners: [Corner.topRight, Corner.bottomRight]),
    RoundedCornerShape(
        color: Colors.black54,
        corners: [Corner.bottomLeft, Corner.bottomRight]),
    RoundedCornerShape(
        color: Colors.black54, corners: [Corner.topLeft, Corner.topRight]),
    TriangleShape(color: Colors.black54, corner: Corner.topLeft),
    TriangleShape(color: Colors.black54, corner: Corner.topRight),
    TriangleShape(color: Colors.black54, corner: Corner.bottomLeft),
    TriangleShape(color: Colors.black54, corner: Corner.bottomRight),
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

  List<Color> randomColorList(int count) => List.generate(
      count, (_) => currentColors[Random().nextInt(currentColors.length)]);

  List<int> randomNumberList(int count, int max) =>
      List.generate(count, (_) => Random().nextInt(max));
}
