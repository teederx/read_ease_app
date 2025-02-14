import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/quill_delta.dart';

class EditNotesPage extends StatelessWidget {
  const EditNotesPage({
    super.key,
    required this.title,
    required this.bookId,
    required this.notes,
  });

  final Delta notes;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (result, _) async {
        if (!result) {
          final response = await _onPop();
          // ignore: use_build_context_synchronously
          if (response) return Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              final result = await _onPop();
              // ignore: use_build_context_synchronously
              if (result) return Navigator.pop(context);
            },
          ),
        ),
        body: AppPadding(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10.r),
                child: quill.QuillToolbar.simple(
                  controller: _controller,
                  configurations: quill.QuillSimpleToolbarConfigurations(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        width: 1.w,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    toolbarSize: 35.h,
                    multiRowsDisplay: false,
                    showFontSize: true,
                    showFontFamily: true,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 10.w,
                  ),
                  child: Scrollbar(
                    controller: _scrollController,
                    child: quill.QuillEditor(
                      controller: _controller,
                      focusNode: _focusNode,
                      scrollController: _scrollController,
                      configurations: const quill.QuillEditorConfigurations(
                        placeholder: 'Type your notes here...',
                      ),
                    ),
                  ),
                ),
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _saveNotes();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.secondaryColor,
                        textStyle: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        )),
                    child: Text(
                      widget.notes.isEmpty || widget.notes == '[]'
                          ? 'Add Notes'
                          : 'Edit Notes',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
