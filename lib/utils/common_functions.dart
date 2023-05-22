import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'dart:typed_data';

Future<Uint8List?> compressFile(File file) async {
  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    minWidth: 1080,
    minHeight: 1080,
    quality: 90,
  );
  return result;
}
