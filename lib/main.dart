import 'dart:math';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tiles/color_selector.dart';

import 'package:tiles/complexity_selector.dart';
import 'package:tiles/download_button.dart';
import 'package:tiles/mirored_tiles.dart';
import 'package:tiles/shape.dart';
import 'package:tiles/shape_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const backgroundColor = Color(0xFFe9dbba);
  static const colorPalet = [
    Color(0xFFDEA540),
    Color(0xFF306285),
    Color(0xFF447955),
    Color(0xFFA94230),
    Color(0xFF424242),
  ];

  final globalKey = GlobalKey();

  var tileAmount = 3;
  var currentColors = [
    const Color(0xFFDEA540),
    const Color(0xFF306285),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _tiles(),
          _controls(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.replay),
      ),
    );
  }

  Screenshot<dynamic> _tiles() {
    final randomNums =
        randomNumbers(tileAmount * tileAmount, Corner.values.length);
    final colors = randomColors(tileAmount * tileAmount);
    Widget tile = ShapeGrid(
      size: const Size(300, 300),
      horizontalTileCount: tileAmount,
      randomNums: randomNums,
      colors: colors,
    );
    return Screenshot(
      controller: widget.screenshotController,
      child: Center(
        child: FittedBox(
          child: Container(
              color: backgroundColor,
              height: 800,
              width: 800,
              child: MiroredTiles(tile: tile)),
        ),
      ),
    );
  }

  Widget _controls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DownloadButton(controller: widget.screenshotController),
            const SizedBox(height: 6),
            ComplexitySelector(
              tileAmount: tileAmount,
              changeTileAmount: (newTileAmount) {
                setState(() {
                  tileAmount = newTileAmount;
                });
              },
            ),
            const SizedBox(height: 6),
            ColorSelector(
                colorPalet: colorPalet,
                currentColors: currentColors,
                changeCurrentColors: (newColors) {
                  setState(() {
                    currentColors = newColors;
                  });
                })
          ],
        ),
      ],
    );
  }

  List<int> randomNumbers(int count, int max) {
    final List<int> numbers = <int>[];
    for (int i = 0; i < count; i++) {
      numbers.add(Random().nextInt(max));
    }
    return numbers;
  }

  List<Color> randomColors(int count) {
    final List<Color> colors = <Color>[];
    for (int i = 0; i < count; i++) {
      colors.add(
        currentColors[Random().nextInt(currentColors.length)],
      );
    }
    return colors;
  }
}
