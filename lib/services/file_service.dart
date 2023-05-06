import 'dart:convert';

import 'package:flutter/services.dart';

class FileService {
  static Future<String> getJsonContent(String path) async {
      ByteData byte = await rootBundle.load(path);
      var list = byte.buffer.asUint8List(byte.offsetInBytes,byte.lengthInBytes);
      return utf8.decode(list);
  }
}