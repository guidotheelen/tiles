import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tiles/color_selector.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

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

  final screenshotController = ScreenshotController();
  final globalKey = GlobalKey();
  final widthController = TextEditingController();
  final heightController = TextEditingController();

  var horizontalTileCount = 3;
  var verticalTileCount = 3;
  var mirroredHorizontal = true;
  var mirroredVertical = true;
  var currentColors = [
    const Color(0xFFDEA540),
    const Color(0xFF306285),
  ];

  @override
  void initState() {
    super.initState();
    widthController.text = horizontalTileCount.toString();
    heightController.text = verticalTileCount.toString();
  }

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
    final amount = horizontalTileCount * verticalTileCount;
    final randomNums = randomNumbers(amount, Corner.values.length);
    final colors = randomColors(amount);
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
              mirroredHorizontal: mirroredHorizontal,
              mirroredVertical: mirroredVertical,
            ),
          ),
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
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                right: 8.0,
              ),
              child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.dashboard),
                  label: const Text('Download SVG')),
            ),
            DownloadButton(controller: screenshotController),
            const SizedBox(height: 6),
            Row(
              children: [
                _sizeInput('Width', widthController, (val) {
                  setState(() {
                    horizontalTileCount = val;
                  });
                }),
                const SizedBox(width: 6),
                _sizeInput('Height', heightController, (val) {
                  setState(() {
                    verticalTileCount = val;
                  });
                }),
                const SizedBox(width: 6)
              ],
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

  SizedBox _sizeInput(
      String text, TextEditingController controller, Function(int) setSize) {
    return SizedBox(
      width: 80,
      child: TextField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: text,
        ),
        onChanged: (val) => setSize(int.parse(val)),
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
