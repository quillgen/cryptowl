import 'dart:io';

import '../common/path_util.dart';

class FileService {
  static const String configFileName = "config.kdbx";

  Future<File> getConfigFile() async {
    return File(await PathUtil.getLocalPath(configFileName));
  }

  Future<bool> hasConfigFile() async {
    final File config = await getConfigFile();
    return config.existsSync();
  }
}
