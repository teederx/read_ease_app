import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:read_ease_app/core/constants/app_colors.dart';
import 'package:read_ease_app/features/books/presentation/content/providers/book_list_provider/book_list_provider.dart';

import '../../../../../core/utils/app_padding.dart';

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
          notes: '',
        );
    if(!mounted) return;
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
                  title: 'Book Title',
                  controller: _bookTitleController,
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

class SelectImage extends StatelessWidget {
  const SelectImage({
    super.key,
    this.pickFromGallery,
    this.takeFromCamera,
    this.imageUrl = '',
  });

  final void Function()? pickFromGallery;
  final void Function()? takeFromCamera;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cover Image',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w200,
            color: AppColors.secondaryColor2,
          ),
        ),
        5.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor1,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: imageUrl == null || imageUrl == ''
                  ? SvgPicture.asset(
                      'assets/icons/book.svg',
                      fit: BoxFit.fill,
                    )
                  : Image.memory(
                      base64Decode(imageUrl!),
                      fit: BoxFit.cover,
                    ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: takeFromCamera,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.secondaryColor,
                    backgroundColor: AppColors.primaryColor,
                  ),
                  label: const Text(
                    'Take a picture',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: pickFromGallery,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.secondaryColor,
                    backgroundColor: AppColors.primaryColor,
                  ),
                  label: const Text('Select from Gallery',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      )),
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class MyFields extends StatelessWidget {
  const MyFields({
    super.key,
    this.maxLines = 1,
    required this.title,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  final String title;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w200,
            color: AppColors.secondaryColor2,
          ),
        ),
        5.verticalSpace,
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.w,
                color: AppColors.primaryColor,
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
