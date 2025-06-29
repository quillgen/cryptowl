import 'package:cryptowl/src/database/database.dart';
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

    final items = await db.noteList().get();

    return items.map((item) {
      return NoteBasic(
        id: item.id,
        classification: item.classification,
        categoryId: item.categoryId,
        title: item.title,
        abstract: item.abstract,
        createTime: _parseDatetime(item.createTime)!,
        lastUpdateTime: _parseDatetime(item.lastUpdateTime)!,
      );
    }).toList();
  }

  DateTime? _parseDatetime(String? dt) {
    return dt == null ? null : DateTime.parse(dt);
  }

  Future<NoteEntity> insert(NoteEntity item) async {
    final db = await requireDb();
    await db.into(db.notes).insert(item);
    return item;
  }

  Future<Note> findById(String id) async {
    final db = await requireDb();
    final item = await (db.notes.select()..where((tbl) => tbl.id.equals(id)))
        .getSingle();

    return Note.fromEntity(item);
  }
}
