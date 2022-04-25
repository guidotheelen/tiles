import 'dart:math' show Random;

import 'package:flutter/material.dart';

class TileLogic {
  final backgroundColor = const Color(0xFFe9dbba);
  final colorPalet = const [
    Color(0xFFDEA540),
    Color(0xFF306285),
    Color(0xFF447955),
    Color(0xFFA94230),
    Color(0xFF424242),
  ];

  var currentColors = [
    const Color(0xFFDEA540),
    const Color(0xFF306285),
  ];
  var horizontalTileCount = 3;
  var verticalTileCount = 3;
  var mirroredHorizontally = true;
  var mirroredVertically = true;

  List<Color> randomColorList(int count) => List.generate(
      count, (_) => currentColors[Random().nextInt(currentColors.length)]);

  List<int> randomNumberList(int count, int max) =>
      List.generate(count, (_) => Random().nextInt(max));
}
