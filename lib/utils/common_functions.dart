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

// Future<File> compressImage(File file,String targePath) async {
//   final result = await FlutterImageCompress.compressAndGetFile(
//     file.absolute.path,
//     targePath,
//     minWidth: 1080,
//     minHeight: 1080,
//     quality: 90,
//   );
//   return result;
// }
//
//
// Future<File> getFileImage(File file)async{
//   final dir= await path_provider.getTemporaryDirectory();
//   final targetPath=dir.absolute.path + ".jpg";
//   final imageFile=await compressImage(file,targetPath);
//   return imageFile;
// }
