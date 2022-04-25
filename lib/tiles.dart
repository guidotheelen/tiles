import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import 'package:tiles/shape.dart';
import 'package:tiles/shape_grid.dart';

import 'mirored_tiles.dart';

class Tiles extends StatelessWidget {
  final ScreenshotController screenshotController;
  final Color backgroundColor;
  final bool mirroredHorizontally;
  final bool mirroredVertically;
  final int horizontalTileCount;
  final int verticalTileCount;
  final List<Color> colors;
  final Function(int count) randomColorList;
  final Function(int count, int max) randomNumbers;

  const Tiles({
    Key? key,
    required this.screenshotController,
    required this.backgroundColor,
    required this.mirroredHorizontally,
    required this.mirroredVertically,
    required this.horizontalTileCount,
    required this.verticalTileCount,
    required this.colors,
    required this.randomColorList,
    required this.randomNumbers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final amount = horizontalTileCount * verticalTileCount;
    final randomNums = randomNumbers(amount, Corner.values.length);
    final colors = randomColorList(amount);
    final tile = ShapeGrid(
      horizontalTileCount: horizontalTileCount,
      verticalTileCount: verticalTileCount,
      randomNums: randomNums,
      colors: colors,
    );

    return Screenshot(
      controller: screenshotController,
      child: Center(
        child: FittedBox(
          child: Container(
            color: backgroundColor,
            height: 800,
            width: 800,
            child: MiroredTiles(
              tile: tile,
              mirroredHorizontal: mirroredHorizontally,
              mirroredVertical: mirroredVertically,
            ),
          ),
        ),
      ),
    );
  }
}
