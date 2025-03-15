import 'package:cryptowl/src/repositories/base_repository.dart';
import 'package:drift/drift.dart';

import '../domain/note.dart';

class NoteRepository extends SqlcipherRepository {
  NoteRepository(super.ref);

  Future<List<NoteBasic>> listByFilters(
      List<int> classifications, bool includeDeleted) async {
    final db = await requireDb();

    var query = db.notes.classification.isIn(classifications);
    if (!includeDeleted) {
      query = query & db.notes.isDeleted.isValue(0);
    }

    final items = await (db.notes.selectOnly()
          ..where(query)
          ..addColumns([
            db.notes.id,
            db.notes.classification,
            db.notes.categoryId,
            db.notes.title,
            db.notes.createTime,
            db.notes.lastUpdateTime,
            db.notes.isDeleted
          ]))
        .get();

    return items.map((item) {
      return NoteBasic(
        id: item.read(db.notes.id)!,
        classification: item.read(db.notes.classification)!,
        categoryId: item.read(db.notes.categoryId)!,
        title: item.read(db.notes.title)!,
        createTime: _parseDatetime(item.read(db.notes.createTime))!,
        lastUpdateTime: _parseDatetime(item.read(db.notes.lastUpdateTime))!,
      );
    }).toList();
  }

  DateTime? _parseDatetime(String? dt) {
    return dt == null ? null : DateTime.parse(dt);
  }
}
