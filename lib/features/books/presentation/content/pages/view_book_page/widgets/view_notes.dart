import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/quill_delta.dart';
import 'package:read_ease_app/features/books/presentation/content/widgets/no_data.dart';


class ViewNotes extends StatefulWidget {
  const ViewNotes({
    super.key,
    required this.notes,
  });
  final String notes;

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const exampleNote = '''[
    {"insert":"Click the pen icon to add a new note.\\n"}
    ]''';
    //Convert serialized json to delta
    Delta delta = Delta.fromJson(jsonDecode(exampleNote));

    bool hasData = false;
    if (widget.notes.isEmpty || widget.notes == '[]') {
      setState(() {
        hasData = false;
      });
    } else {
      setState(() {
        hasData = true;
        delta = Delta.fromJson(jsonDecode(widget.notes));
      });
    }

    final document = quill.Document.fromDelta(delta);

    return Expanded(
      child: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          child: Container(
            child: hasData
                ? quill.QuillEditor.basic(
                    controller: quill.QuillController(
                      document: document,
                      selection: const TextSelection.collapsed(offset: 0),
                      readOnly: true,
                    ),
                  )
                : const NoData(dataEntry: DataEntry.noNote),
          ),
        ),
      ),
    );
  }
}
