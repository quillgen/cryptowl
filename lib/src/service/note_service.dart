import 'package:cryptowl/src/database/database.dart';
import 'package:cryptowl/src/repositories/note_repository.dart';

import '../common/random_util.dart';

class NoteService {
  final NoteRepository repository;

  NoteService(this.repository);

  Future<NoteEntity> createNote(String delta, String plainText) async {
    final now = DateTime.now().toIso8601String();
    var title = plainText;
    if (title.length > 100) {
      title = title.substring(0, 100);
    }
    final re = RegExp(r'\\n');
    final lines = title.split(re);
    title = lines[0].trim();
    final item = NoteEntity(
      id: RandomUtil.generateUUID(),
      classification: 0,
      title: title,
      content: delta,
      isFavorite: 0,
      categoryId: 0,
      createTime: now,
      lastUpdateTime: now,
      isDeleted: 0,
    );
    return repository.insert(item);
  }
}
