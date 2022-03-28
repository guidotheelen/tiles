import 'dart:math';

import 'package:flutter/material.dart';

class MiroredTiles extends StatelessWidget {
  final Widget tile;
  final bool mirroredHorizontal;
  final bool mirroredVertical;

  const MiroredTiles({
    Key? key,
    required this.tile,
    required this.mirroredHorizontal,
    required this.mirroredVertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        height: 600,
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tile,
                  if (mirroredVertical)
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: tile,
                    ),
                ],
              ),
              if (mirroredHorizontal)
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationX(pi),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tile,
                      if (mirroredVertical)
                        Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(pi),
                            child: tile),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
