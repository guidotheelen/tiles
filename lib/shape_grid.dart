import 'package:flutter/material.dart';

import 'package:tiles/shape.dart';

class ShapeGrid extends StatelessWidget {
  final Size size;
  final int horizontalTileCount;
  final int verticalTileCount;
  final List<Color> colors;
  final List<int> randomNums;

  const ShapeGrid({
    Key? key,
    required this.size,
    required this.horizontalTileCount,
    required this.verticalTileCount,
    required this.colors,
    required this.randomNums,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: List.generate(
          horizontalTileCount,
          (yIndex) => Row(
            children: List.generate(
              verticalTileCount,
              (xIndex) {
                final index = yIndex * verticalTileCount + xIndex;
                return Shape(
                  size: size.width / horizontalTileCount,
                  color: colors[index],
                  corner: Corner.values[randomNums[index]],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
