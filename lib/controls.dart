import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';

import 'package:tiles/color_selector.dart';
import 'package:tiles/png_download_button.dart';
import 'package:tiles/tile_logic.dart';

class Controls extends StatelessWidget {
  final ScreenshotController screenshotController;
  final TextEditingController widthController;
  final TextEditingController heightController;
  final List<Color> colorPalet;
  final List<Color> currentColors;
  final Map<Shape, Function> shapes;
  final List<Shape> currentShapes;
  final int horizontalTileCount;
  final int verticalTileCount;
  final bool mirrorHorizontally;
  final bool mirrorVertically;
  final Function(List<Color>) setCurrentColors;
  final Function(int) setWidth;
  final Function(int) setHeight;
  final Function(Shape) switchShape;
  final VoidCallback switchMirrorHorizontally;
  final VoidCallback switchMirrorVertically;

  const Controls({
    Key? key,
    required this.screenshotController,
    required this.widthController,
    required this.heightController,
    required this.colorPalet,
    required this.currentColors,
    required this.shapes,
    required this.currentShapes,
    required this.horizontalTileCount,
    required this.verticalTileCount,
    required this.mirrorHorizontally,
    required this.mirrorVertically,
    required this.setCurrentColors,
    required this.setWidth,
    required this.setHeight,
    required this.switchShape,
    required this.switchMirrorHorizontally,
    required this.switchMirrorVertically,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          _sizeUnit(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _sizeUnit(),
              _complexitySelector(),
              _sizeUnit(),
              ColorSelector(
                colorPalet: colorPalet,
                currentColors: currentColors,
                changeCurrentColors: (newColors) => setCurrentColors(newColors),
              ),
              _iconCheckbox(
                const Icon(Icons.vertical_distribute),
                mirrorHorizontally,
                switchMirrorHorizontally,
              ),
              _iconCheckbox(
                const Icon(Icons.horizontal_distribute),
                mirrorVertically,
                switchMirrorVertically,
              ),
              Expanded(child: Container()),
              _sizeUnit(),
              PNGDownloadButton(controller: screenshotController),
              _sizeUnit(),
            ],
          ),
          _sizeUnit(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _sizeUnit(),
              for (MapEntry<Shape, Function> shape in shapes.entries)
                _iconCheckbox(
                  shape.value.call(Colors.black54),
                  currentShapes.contains(shape.key),
                  () => switchShape(shape.key),
                ),
            ],
          ),
          _sizeUnit(),
        ],
      ),
    );
  }

  Column _iconCheckbox(Widget icon, bool value, VoidCallback onChanged) =>
      Column(
        children: [
          icon,
          Checkbox(
            value: value,
            onChanged: (_) => onChanged(),
          )
        ],
      );

  Row _complexitySelector() {
    return Row(
      children: [
        _sizeInput(
          'Width',
          widthController,
          (val) => setWidth(val),
        ),
        _sizeUnit(),
        _sizeInput(
          'Height',
          heightController,
          (val) => setHeight(val),
        ),
      ],
    );
  }

  SizedBox _sizeUnit([double? size]) => SizedBox(
        width: size ?? 10,
        height: size ?? 10,
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
