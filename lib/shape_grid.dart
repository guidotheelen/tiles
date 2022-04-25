import 'package:flutter/material.dart';

import 'tile_logic.dart';

class ShapeGrid extends StatelessWidget {
  final int horizontalTileCount;
  final int verticalTileCount;
  final List<Color> colors;
  final List<int> randomNums;
  final List<Shape> currentShapes;
  final Map<Shape, Widget> shapes;

  const ShapeGrid({
    Key? key,
    required this.horizontalTileCount,
    required this.verticalTileCount,
    required this.colors,
    required this.randomNums,
    required this.currentShapes,
    required this.shapes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        verticalTileCount,
        (yIndex) => Row(
          children: List.generate(
            horizontalTileCount,
            (xIndex) {
              final index = yIndex * horizontalTileCount + xIndex;
              return shapes[currentShapes[randomNums[index]]] ?? Container();
            },
          ),
        ),
      ),
    );
  }
}
