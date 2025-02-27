import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/domain/password.dart';
import 'package:cryptowl/src/pages/passwords.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kdbx/kdbx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../providers.dart';
import '../components/empty.dart';
import '../components/password_detail.dart';
import '../components/password_edit.dart';

part 'detail_panel.g.dart';

enum ViewType { view, create, empty }

@riverpod
class DetailPanelState extends _$DetailPanelState {
  @override
  ViewType build() {
    return ViewType.view;
  }

  void setCreateMode() {
    ref.read(selectedPasswordProvider.notifier).setSelectedPassword(null);
    state = ViewType.create;
  }

  void setViewMode(PasswordBasic selected) {
    ref.read(selectedPasswordProvider.notifier).setSelectedPassword(selected);
    state = ViewType.view;
  }

  void setEmpty() {
    ref.read(selectedPasswordProvider.notifier).setSelectedPassword(null);
    state = ViewType.empty;
  }

  Future<void> createPassword(String title, ProtectedValue password) async {
    final repository = ref.read(passwordRepositoryProvider);
    final created = await repository.create(title, password);
    logger.fine("New password created: id=${created.id}");
    ref.refresh(passwordsProvider);
    setViewMode(
      PasswordBasic(
          id: created.id,
          type: created.type,
          categoryId: created.categoryId,
          title: created.title,
          createTime: created.createTime,
          lastUpdateTime: created.lastUpdateTime),
    );
  }
}

@riverpod
class SelectedPassword extends _$SelectedPassword {
  @override
  PasswordBasic? build() {
    return null;
  }

  void setSelectedPassword(PasswordBasic? selected) {
    state = selected;
  }
}

@riverpod
Future<Password?> selectedPasswordDetail(Ref ref) async {
  final p = ref.watch(selectedPasswordProvider);
  if (p == null) {
    return null;
  }
  logger.fine("Fetching password detail for ${p.id}");
  return ref.read(passwordRepositoryProvider).findById(p.id);
}

class DetailPanel extends ConsumerWidget {
  const DetailPanel({super.key});

  Widget _renderActions(WidgetRef ref) {
    final viewState = ref.watch(detailPanelStateProvider);
    final viewStateNotifier = ref.read(detailPanelStateProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          tooltip: "Back",
          onPressed: () {
            viewStateNotifier.setEmpty();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        Expanded(child: Container()),
        if (viewState == ViewType.view)
          IconButton(
            tooltip: "Edit",
            onPressed: () {},
            icon: Icon(Icons.edit),
          ),
        if (viewState == ViewType.view)
          IconButton(
            tooltip: "Move to trash",
            onPressed: () {},
            icon: Icon(Icons.delete),
          ),
        if (viewState == ViewType.view)
          IconButton(
            tooltip: "Send",
            onPressed: () {},
            icon: Icon(Icons.forward),
          ),
      ],
    );
  }

  Widget _renderContent(WidgetRef ref, content) {
    return Column(
      children: [
        _renderActions(ref),
        Container(
          constraints: BoxConstraints(
            maxWidth: 550,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: content,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panelState = ref.watch(detailPanelStateProvider);
    logger.fine("Detail panel state is: $panelState");

    if (panelState == ViewType.create) {
      return _renderContent(ref, PasswordCreatePage());
    } else if (panelState == ViewType.view) {
      final selectedState = ref.watch(selectedPasswordDetailProvider);

      return selectedState.when(
        data: (password) => password == null
            ? Empty()
            : _renderContent(
                ref,
                PasswordDetail(
                  password: password,
                )),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) => ErrorWidget(e),
      );
    } else {
      return Empty();
    }
  }
}
