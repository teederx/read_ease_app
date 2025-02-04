import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:read_ease_app/core/constants/app_colors.dart';
import 'package:read_ease_app/features/books/presentation/content/providers/book_list_provider/book_list_provider.dart';

import '../../../../../core/utils/app_padding.dart';
import '../widgets/my_fields.dart';
import '../widgets/select_image.dart';

class AddNewBook extends ConsumerStatefulWidget {
  const AddNewBook({super.key});

  @override
  ConsumerState<AddNewBook> createState() => _AddNewBookState();
}

class _AddNewBookState extends ConsumerState<AddNewBook> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _bookTitleController = TextEditingController();
  final _descController = TextEditingController();
  final _authorController = TextEditingController();
  String? _imageUrl;

  @override
  void dispose() {
    _bookTitleController.dispose();
    _descController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final compressedFile = await FlutterImageCompress.compressWithFile(
        pickedFile.path,
        quality: 50,
      );

      if (compressedFile != null) {
        setState(() {
          _imageUrl = base64Encode(compressedFile);
        });
      }
    }
  }

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    await ref.read(bookListProvider.notifier).addBook(
          imageURL: _imageUrl == null ? '' : _imageUrl!,
          title: _bookTitleController.text.trim(),
          desc: _descController.text.trim(),
          author: _authorController.text.trim(),
        );
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: AppPadding(
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: ListView(
              children: [
                Text(
                  'Add New Book',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                20.verticalSpace,
                SelectImage(
                  pickFromGallery: () => _pickImage(ImageSource.gallery),
                  takeFromCamera: () => _pickImage(ImageSource.camera),
                  imageUrl: _imageUrl,
                ),
                20.verticalSpace,
                MyFields(
                  title: 'Book Title (35 chars)',
                  controller: _bookTitleController,
                  textInputAction: TextInputAction.next,
                  maxLength: 35,
                  hintText: 'Enter book title',
                  validator: (value) {
                    if (value == '') {
                      return 'This entry is required';
                    }
                    return null;
                  },
                ),
                20.verticalSpace,
                MyFields(
                  title: 'Author',
                  controller: _authorController,
                  textInputAction: TextInputAction.next,
                  hintText: 'Enter the book\'s author',
                  validator: (value) {
                    if (value == '') {
                      return 'This entry is required';
                    }
                    return null;
                  },
                ),
                20.verticalSpace,
                MyFields(
                  maxLines: 2,
                  title: 'Description',
                  maxLength: 50,
                  controller: _descController,
                  hintText: 'Enter a short description',
                ),
                40.verticalSpace,
                ElevatedButton.icon(
                  onPressed: () {
                    _submit();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5.h,
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.secondaryColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 13.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  label: Text(
                    'Add Book',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  icon: const Icon(Icons.add_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


