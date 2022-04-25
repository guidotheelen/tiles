import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tiles/controls.dart';
import 'package:tiles/tile_logic.dart';
import 'package:tiles/tiles.dart';

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
  final screenshotController = ScreenshotController();
  final globalKey = GlobalKey();
  final widthController = TextEditingController();
  final heightController = TextEditingController();
  final logic = TileLogic();

  @override
  void initState() {
    super.initState();
    widthController.text = logic.horizontalTileCount.toString();
    heightController.text = logic.verticalTileCount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Controls(
            screenshotController: screenshotController,
            widthController: widthController,
            heightController: heightController,
            colorPalet: logic.colorPalet,
            currentColors: logic.currentColors,
            shapes: logic.shapePalet,
            currentShapes: logic.currentShapes,
            horizontalTileCount: logic.horizontalTileCount,
            verticalTileCount: logic.verticalTileCount,
            mirrorHorizontally: logic.mirrorHorizontally,
            mirrorVertically: logic.mirrorVertically,
            setCurrentColors: (colors) {
              logic.currentColors = colors;
              setState(() {});
            },
            switchMirrorHorizontally: () {
              logic.switchMirrorHorizontally();
              setState(() {});
            },
            switchMirrorVertically: () {
              logic.switchMirrorVertically();
              setState(() {});
            },
            setHeight: (height) {
              logic.verticalTileCount = height;
              setState(() {});
            },
            setWidth: (width) {
              logic.horizontalTileCount = width;
              setState(() {});
            },
            switchShape: (shape) {
              logic.switchShape(shape);
              setState(() {});
            },
          ),
          Tiles(
            screenshotController: screenshotController,
            backgroundColor: logic.backgroundColor,
            mirroredHorizontally: logic.mirrorHorizontally,
            mirroredVertically: logic.mirrorVertically,
            horizontalTileCount: logic.horizontalTileCount,
            verticalTileCount: logic.verticalTileCount,
            colors: logic.currentColors,
            randomColorList: logic.randomColorList,
            randomNumbers: logic.randomNumberList,
            currentShapes: logic.currentShapes,
            shapes: logic.shapePalet,
          ),
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
}
