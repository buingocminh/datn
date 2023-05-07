
import 'dart:io';

import 'package:datn/configs/constants.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future setupHive() async {
  Directory documents = await getApplicationDocumentsDirectory();
  Hive.init(documents.path);
  await Hive.openBox(boxUserSettingName);
}