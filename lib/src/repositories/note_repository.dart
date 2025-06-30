import 'package:cryptowl/src/database/database.dart';
import 'package:cryptowl/src/repositories/base_repository.dart';
import 'package:drift/drift.dart';

import '../domain/note.dart';

class NoteRepository extends SqlcipherRepository {
  NoteRepository(super.ref);

  Future<List<NoteBasic>> list({NoteSortType? sortType}) async {
    final db = await requireDb();
    final query = db.noteView.select();
    final records = await query.get();
    return records.map((item) {
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

  Future<NoteEntity> update(String id,
      {int? classification,
      String? title,
      String? content,
      String? plainText}) async {
    final db = await requireDb();
    final now = DateTime.now();
    final existing = await (db.notes.select()
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();
    final item = NoteEntity(
      id: id,
      categoryId: existing.categoryId,
      title: title ?? existing.title,
      createTime: existing.createTime,
      lastUpdateTime: now.toIso8601String(),
      classification: classification ?? existing.classification,
      content: content ?? existing.content,
      plainText: plainText ?? existing.plainText,
      isFavorite: existing.isFavorite,
      isDeleted: existing.isDeleted,
    );
    await db.notes.replaceOne(item.toCompanion(true));
    return item;
  }

  Future<Note> findById(String id) async {
    final db = await requireDb();
    final item = await (db.notes.select()..where((tbl) => tbl.id.equals(id)))
        .getSingle();

    return Note.fromEntity(item);
  }
}
