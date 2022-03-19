import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<Color> colorPalet;
  final List<Color> currentColors;
  final Function(List<Color>) changeCurrentColors;

  const ColorSelector({
    Key? key,
    required this.colorPalet,
    required this.currentColors,
    required this.changeCurrentColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                val!
                    ? currentColors.add(colorPalet[index])
                    : currentColors.length > 1
                        ? currentColors.remove(colorPalet[index])
                        : null;
                changeCurrentColors(currentColors);
              }),
        ],
      ),
    );
  }
}
