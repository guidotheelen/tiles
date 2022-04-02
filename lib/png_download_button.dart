import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class PNGDownloadButton extends StatelessWidget {
  final ScreenshotController controller;

  const PNGDownloadButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xFF306285),
          ),
        ),
        icon: const Icon(Icons.image),
        onPressed: _downloadImage,
        label: const Text('Download PNG'));
  }

  void _downloadImage() {
    controller.capture().then((Uint8List? image) {
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
}
