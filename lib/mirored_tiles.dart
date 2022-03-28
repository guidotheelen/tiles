import 'dart:math';

import 'package:flutter/material.dart';

class MiroredTiles extends StatelessWidget {
  final Widget tile;

  const MiroredTiles({
    Key? key,
    required this.tile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            tile,
            // Transform(
            //   alignment: Alignment.center,
            //   transform: Matrix4.rotationY(pi),
            //   child: tile,
            // ),
          ],
        ),
        // Transform(
        //   alignment: Alignment.center,
        //   transform: Matrix4.rotationX(pi),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       tile,
        //       Transform(
        //           alignment: Alignment.center,
        //           transform: Matrix4.rotationY(pi),
        //           child: tile),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
