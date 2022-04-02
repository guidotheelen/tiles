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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        colorPalet.length,
        (index) => _colorSetting(index),
      ),
    );
  }

  Widget _colorSetting(int index) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: colorPalet[index],
      ),
      child: Checkbox(
          activeColor: colorPalet[index],
          value: currentColors.contains(colorPalet[index]),
          onChanged: (val) {
            val!
                ? currentColors.add(colorPalet[index])
                : currentColors.length > 1
                    ? currentColors.remove(colorPalet[index])
                    : null;
            changeCurrentColors(currentColors);
          }),
    );
  }
}
