import 'dart:convert';
import 'dart:io';

import 'package:cryptowl/src/providers/notes.dart';
import 'package:cryptowl/src/providers/repositories.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/custom_leading.dart';
import '../localization/app_localizations.dart';

class NoteCreatePage extends ConsumerStatefulWidget {
  const NoteCreatePage({super.key});

  static const String path = '/create';
  static const String name = 'Note Create';

  @override
  ConsumerState<NoteCreatePage> createState() => _NoteCreatePageState();
}

class _NoteCreatePageState extends ConsumerState<NoteCreatePage> {
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<EditorState> _editorKey = GlobalKey();
  late FleatherController _controller;

  @override
  void initState() {
    super.initState();
    final doc = ParchmentDocument();
    _controller = FleatherController(document: doc);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(AppLocalizations.of(context)!.createNote),
        leading: CustomLeading(),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(noteServiceProvider).createNote(
                  jsonEncode(_controller.document.toDelta().toJson()),
                  _controller.document.toPlainText());
              ref.invalidate(notesProvider);
              if (context.mounted) {
                context.pop();
              }
            },
            icon: Icon(RemixIcons.check_line),
          )
        ],
      ),
      body: Column(
        children: [
          FleatherToolbar.basic(controller: _controller, editorKey: _editorKey),
          Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
          Expanded(
            child: FleatherEditor(
              autofocus: true,
              controller: _controller,
              focusNode: _focusNode,
              editorKey: _editorKey,
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              onLaunchUrl: _launchUrl,
              maxContentWidth: 800,
              embedBuilder: _embedBuilder,
              spellCheckConfiguration: SpellCheckConfiguration(
                  spellCheckService: DefaultSpellCheckService(),
                  misspelledSelectionColor: Colors.red,
                  misspelledTextStyle: DefaultTextStyle.of(context).style),
            ),
          ),
        ],
      ),
    );
  }

  void _launchUrl(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    final canLaunch = await canLaunchUrl(uri);
    if (canLaunch) {
      await launchUrl(uri);
    }
  }

  Widget _embedBuilder(BuildContext context, EmbedNode node) {
    if (node.value.type == 'icon') {
      final data = node.value.data;
      // Icons.rocket_launch_outlined
      return Icon(
        IconData(int.parse(data['codePoint']), fontFamily: data['fontFamily']),
        color: Color(int.parse(data['color'])),
        size: 18,
      );
    }

    if (node.value.type == 'image') {
      final sourceType = node.value.data['source_type'];
      ImageProvider? image;
      if (sourceType == 'assets') {
        image = AssetImage(node.value.data['source']);
      } else if (sourceType == 'file') {
        image = FileImage(File(node.value.data['source']));
      } else if (sourceType == 'url') {
        image = NetworkImage(node.value.data['source']);
      }
      if (image != null) {
        return Padding(
          // Caret takes 2 pixels, hence not symmetric padding values.
          padding: const EdgeInsets.only(left: 4, right: 2, top: 2, bottom: 2),
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(image: image, fit: BoxFit.cover),
            ),
          ),
        );
      }
    }

    return defaultFleatherEmbedBuilder(context, node);
  }
}
