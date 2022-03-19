import 'package:flutter/material.dart';

class ComplexityIcon extends StatelessWidget {
  final int amount;

  const ComplexityIcon({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        amount,
        (index) {
          return index.isEven
              ? const SizedBox(height: 4)
              : _complexityIconRow(amount);
        },
      )..add(
          const SizedBox(height: 4),
        ),
    );
  }
}

Row _complexityIconRow(int amount) {
  return Row(
    children: List.generate(
      amount,
      (index) {
        return index.isEven
            ? const SizedBox(width: 4)
            : _complexityIconCircle();
      },
    )..add(
        const SizedBox(width: 4),
      ),
  );
}

Container _complexityIconCircle() {
  return Container(
    height: 4,
    width: 4,
    decoration: const BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(4))),
  );
}
