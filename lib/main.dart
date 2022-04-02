import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tiles/color_selector.dart';

import 'package:tiles/png_download_button.dart';
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
        accentColor: const Color(0xFF306285),
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
  var mirroredHorizontally = true;
  var mirroredVertically = true;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _controls(),
          _tiles(),
          Container(),
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

  Widget _tiles() {
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
              mirroredHorizontal: mirroredHorizontally,
              mirroredVertical: mirroredVertically,
            ),
          ),
        ),
      ),
    );
  }

  Widget _controls() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          _sizeUnit(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _sizeUnit(),
              _complexitySelector(),
              _sizeUnit(),
              ColorSelector(
                colorPalet: colorPalet,
                currentColors: currentColors,
                changeCurrentColors: (newColors) {
                  setState(() {
                    currentColors = newColors;
                  });
                },
              ),
              Column(
                children: [
                  const Icon(Icons.vertical_distribute),
                  Checkbox(
                    value: mirroredHorizontally,
                    onChanged: (_) => setState(() {
                      mirroredHorizontally = !mirroredHorizontally;
                    }),
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.horizontal_distribute),
                  Checkbox(
                    value: mirroredVertically,
                    onChanged: (_) => setState(() {
                      mirroredVertically = !mirroredVertically;
                    }),
                  )
                ],
              ),
              Expanded(child: Container()),
              _sizeUnit(),
              // _svgDownloadButton(),
              // _sizeUnit(),
              PNGDownloadButton(controller: screenshotController),
              _sizeUnit(),
            ],
          ),
          _sizeUnit(10),
        ],
      ),
    );
  }

  ElevatedButton _svgDownloadButton() {
    return ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.dashboard),
        label: const Text('Download SVG'));
  }

  Row _complexitySelector() {
    return Row(
      children: [
        _sizeInput('Width', widthController, (val) {
          setState(() {
            horizontalTileCount = val;
          });
        }),
        _sizeUnit(),
        _sizeInput(
          'Height',
          heightController,
          (val) {
            setState(() {
              verticalTileCount = val;
            });
          },
        ),
      ],
    );
  }

  SizedBox _sizeUnit([double? size]) => SizedBox(
        width: size ?? 6,
        height: size ?? 6,
      );

  SizedBox _sizeInput(
      String text, TextEditingController controller, Function(int) setSize) {
    return SizedBox(
      width: 80,
      height: 40,
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
