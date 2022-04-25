import 'package:flutter/material.dart';

import 'package:tiles/rounded_corner_shape.dart';

class ShapeGrid extends StatelessWidget {
  final int horizontalTileCount;
  final int verticalTileCount;
  final List<Color> colors;
  final List<int> randomNums;

  const ShapeGrid({
    Key? key,
    required this.horizontalTileCount,
    required this.verticalTileCount,
    required this.colors,
    required this.randomNums,
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
              return RoundedCornerShape(
                color: colors[index],
                corners: [
                  Corner.values[0],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
