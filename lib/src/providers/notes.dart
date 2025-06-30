import 'dart:async';

import 'package:cryptowl/src/domain/password.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../domain/note.dart';
import 'passwords.dart';
import 'repositories.dart';

final _logger = Logger("NotesNotifier");

class AsyncNotesNotifier extends AsyncNotifier<List<NoteBasic>> {
  @override
  FutureOr<List<NoteBasic>> build() {
    final filters = ref.watch(passwordFilterProvider);
    final includeDeleted = filters.contains(PasswordFilter.deleted);
    final classifications = <int>[];
    if (filters.contains(PasswordFilter.topSecret)) {
      classifications.add(TOP_SECRET);
    }
    if (filters.contains(PasswordFilter.secret)) {
      classifications.add(SECRET);
    }
    if (filters.contains(PasswordFilter.confidential)) {
      classifications.add(CONFIDENTIAL);
    }
    return ref.read(noteRepositoryProvider).list();
  }
}

final notesProvider =
    AsyncNotifierProvider<AsyncNotesNotifier, List<NoteBasic>>(() {
  return AsyncNotesNotifier();
});

final noteDetailProvider =
    FutureProvider.autoDispose.family<Note, String>((ref, id) async {
  _logger.fine("Fetching note detail for $id");
  return ref.read(noteRepositoryProvider).findById(id);
});
