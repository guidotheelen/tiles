import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:html' as html;

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
  final tileAmount = 3;
  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final randomNums =
        randomNumbers(tileAmount * tileAmount, _Corner.values.length);
    final colors = randomColors(tileAmount * tileAmount);
    Widget tile =
        _tileGrid(const Size(300, 300), tileAmount, randomNums, colors);
    return Scaffold(
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [_downloadButton()],
              ),
            ],
          ),
          Screenshot(
            controller: widget.screenshotController,
            child: Center(
              child: Container(
                  color: Colors.white,
                  height: 600 + 600 / tileAmount,
                  width: 600 + 600 / tileAmount,
                  child: _mirroredTiles(tile)),
            ),
          ),
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

  Padding _downloadButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
          icon: const Icon(Icons.download_sharp),
          onPressed: _downloadImage,
          label: const Text('Download PNG')),
    );
  }

  void _downloadImage() {
    widget.screenshotController.capture().then((Uint8List? image) {
      if (image != null) {
        // final file = File.fromRawPath(image);
        final pngBytes = image.buffer.asUint8List();
        final blob = html.Blob(<dynamic>[pngBytes], 'application/octet-stream');
        html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob))
          ..setAttribute('download', 'tile.png')
          ..click();
      }
    }).catchError((onError) {});
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
        Random().nextBool() ? Colors.blue : Colors.amber,
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
