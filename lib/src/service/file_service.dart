import 'dart:io';

import '../common/path_util.dart';

class FileService {
  static const String configFileName = "config.json";

  Future<File> getConfigFile() async {
    return File(await PathUtil.getLocalPath(configFileName));
  }

  Future<bool> hasConfigFile() async {
    final File config = await getConfigFile();
    return config.existsSync();
  }

  Future<void> writeConfig(String content) async {
    final file = await getConfigFile();
    await file.writeAsString(content, flush: true);
  }

  Future<void> writeFile(String content, String fileName) async {
    final file = File(await PathUtil.getLocalPath(fileName));
    print("saving ${file}...");
    await file.writeAsString(content, flush: true);
  }
}
