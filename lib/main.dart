import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tiles/color_selector.dart';

import 'package:tiles/png_download_button.dart';
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
          _controls(),
          Tiles(
            screenshotController: screenshotController,
            backgroundColor: logic.backgroundColor,
            mirroredHorizontally: logic.mirroredHorizontally,
            mirroredVertically: logic.mirroredVertically,
            horizontalTileCount: logic.horizontalTileCount,
            verticalTileCount: logic.verticalTileCount,
            colors: logic.currentColors,
            randomColorList: logic.randomColorList,
            randomNumbers: logic.randomNumberList,
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
                colorPalet: logic.colorPalet,
                currentColors: logic.currentColors,
                changeCurrentColors: (newColors) {
                  setState(() {
                    logic.currentColors = newColors;
                  });
                },
              ),
              Column(
                children: [
                  const Icon(Icons.vertical_distribute),
                  Checkbox(
                    value: logic.mirroredHorizontally,
                    onChanged: (_) => setState(() {
                      logic.mirroredHorizontally = !logic.mirroredHorizontally;
                    }),
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.horizontal_distribute),
                  Checkbox(
                    value: logic.mirroredVertically,
                    onChanged: (_) => setState(() {
                      logic.mirroredVertically = !logic.mirroredVertically;
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

  Row _complexitySelector() {
    return Row(
      children: [
        _sizeInput('Width', widthController, (val) {
          setState(() {
            logic.horizontalTileCount = val;
          });
        }),
        _sizeUnit(),
        _sizeInput(
          'Height',
          heightController,
          (val) {
            setState(() {
              logic.verticalTileCount = val;
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
}
