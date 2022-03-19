import 'dart:math';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import 'package:tiles/complexity_selector.dart';
import 'package:tiles/download_button.dart';

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
    Color(0xFFDEA540),
    Color(0xFF306285),
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
        randomNumbers(tileAmount * tileAmount, _Corner.values.length);
    final colors = randomColors(tileAmount * tileAmount);
    Widget tile =
        _tileGrid(const Size(300, 300), tileAmount, randomNums, colors);
    return Screenshot(
      controller: widget.screenshotController,
      child: Center(
        child: FittedBox(
          child: Container(
              color: backgroundColor,
              height: 800,
              width: 800,
              child: _mirroredTiles(tile)),
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
            _colorSelector()
          ],
        ),
      ],
    );
  }

  Widget _colorSelector() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: List.generate(
          colorPalet.length,
          (index) => _colorSetting(index),
        ),
      ),
    );
  }

  Widget _colorSetting(int index) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(width: 30, height: 30, color: colorPalet[index]),
          Checkbox(
            value: currentColors.contains(colorPalet[index]),
            onChanged: (val) {
              setState(() {
                val!
                    ? currentColors.add(colorPalet[index])
                    : currentColors.length > 1
                        ? currentColors.remove(colorPalet[index])
                        : null;
              });
            },
          ),
        ],
      ),
    );
  }

  Column _mirroredTiles(Widget tile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            tile,
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: tile,
            ),
          ],
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(pi),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              tile,
              Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi),
                  child: tile),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tileGrid(Size size, int horizontalTileCount, List<int> randomNums,
      List<Color> colors) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: horizontalTileCount,
        ),
        itemBuilder: (_, index) {
          return _roundedEdge(
            size.width / horizontalTileCount,
            colors[index],
            _Corner.values[randomNums[index]],
          );
        },
        itemCount: horizontalTileCount * horizontalTileCount,
      ),
    );
  }

  Container _roundedEdge(double size, Color color, _Corner corner) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: corner == _Corner.topLeft || corner == _Corner.all
              ? Radius.circular(size)
              : Radius.zero,
          topRight: corner == _Corner.topRight || corner == _Corner.all
              ? Radius.circular(size)
              : Radius.zero,
          bottomLeft: corner == _Corner.bottomLeft || corner == _Corner.all
              ? Radius.circular(size)
              : Radius.zero,
          bottomRight: corner == _Corner.bottomRight || corner == _Corner.all
              ? Radius.circular(size)
              : Radius.zero,
        ),
      ),
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

enum _Corner {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  all,
}
