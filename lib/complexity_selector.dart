import 'package:flutter/material.dart';

import 'complexity_icon.dart';

class ComplexitySelector extends StatelessWidget {
  final int tileAmount;
  final Function(int) changeTileAmount;

  const ComplexitySelector({
    Key? key,
    required this.tileAmount,
    required this.changeTileAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _iconRadioButton(4),
            const SizedBox(width: 8.0),
            _iconRadioButton(6),
            const SizedBox(width: 8.0),
            _iconRadioButton(8),
            const SizedBox(width: 8.0),
            _iconRadioButton(10),
          ],
        ),
      ),
    );
  }

  Widget _iconRadioButton(int value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ComplexityIcon(
          amount: value,
        ),
        Radio(
            value: value,
            groupValue: tileAmount * 2,
            onChanged: (_) {
              changeTileAmount(value ~/ 2);
            }),
      ],
    );
  }
}
