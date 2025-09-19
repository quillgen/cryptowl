import 'dart:io';

import 'package:path/path.dart' as path;

import '../common/path_util.dart';

class FileService {
  static const String configFileName = "config.json";

  Future<List<String>> getSqlcipherInstances() async {
    final documentDir = Directory(await PathUtil.getLocalPath("/"));
    return await documentDir
        .list()
        .where(
            (e) => e is File && path.extension(e.path).toLowerCase() == '.enc')
        .map((db) => path.basename(db.path))
        .toList();
  }

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
    await file.writeAsString(content, flush: true);
  }
}
