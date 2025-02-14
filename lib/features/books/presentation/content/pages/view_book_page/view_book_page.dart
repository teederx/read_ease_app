import 'dart:convert';
<<<<<<< HEAD
=======

import 'package:flutter_quill/quill_delta.dart';
>>>>>>> d2a75d37d56767dbb81bc525988f344307ea5f4e
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:read_ease_app/config/router/route.dart';
import 'package:read_ease_app/features/books/presentation/content/providers/book_list_provider/book_list_provider.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../providers/get_a_book/get_a_book.dart';
import 'widgets/completed_button.dart';
import 'widgets/view_notes.dart';

class ViewBookPage extends ConsumerWidget {
  const ViewBookPage({super.key, required this.bookId});

  final String bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mybook = ref.watch(
      getABookProvider(bookId),
    );

<<<<<<< HEAD
=======
    final notes = Delta.fromJson(jsonDecode(mybook.notes));

>>>>>>> d2a75d37d56767dbb81bc525988f344307ea5f4e
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(mybook.title),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(
                RouteNames.editNotes,
<<<<<<< HEAD
                extra: [
                  mybook.bookID,
                  mybook.title,
                  mybook.notes,
                ],
=======
                extra: notes,
>>>>>>> d2a75d37d56767dbb81bc525988f344307ea5f4e
              );
            },
            icon: const Icon(Icons.edit_rounded),
            tooltip: 'Edit Notes',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 5.h,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10.h,
                  ),
                  height: 120.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: mybook.imageURL == ''
                      ? SvgPicture.asset(
                          'assets/icons/book.svg',
                          fit: BoxFit.fill,
                        )
                      : Image.memory(
                          base64Decode(mybook.imageURL),
                          fit: BoxFit.fill,
                        ),
                ),
                SizedBox(
                  height: 120.h,
                  width: 170.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60.h,
                        child: Text(
                          mybook.title,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      10.verticalSpace,
                      FittedBox(
                        child: Text(
                          'By ${mybook.author.characters.first.toUpperCase()}${mybook.author.characters.skip(1).toString()}',
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                      10.verticalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: mybook.isCompleted
                              ? AppColors.primaryColor
                              : AppColors.accentColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          mybook.isCompleted
                              ? 'Completed'
                              : 'Currently Reading',
                          style: TextStyle(
<<<<<<< HEAD
                            fontSize: 10.sp,
=======
                            fontSize: 13.sp,
>>>>>>> d2a75d37d56767dbb81bc525988f344307ea5f4e
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              'Description: ${mybook.desc}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryColor2.withOpacity(0.5),
                fontSize: 13.sp,
              ),
            ),
            5.verticalSpace,
            CompletedButton(
              isCompleted: mybook.isCompleted,
              onPressed: () => ref
                  .read(bookListProvider.notifier)
                  .toggleCompleted(bookId: mybook.bookID),
            ),
            15.verticalSpace,
            Align(
              alignment: Alignment.center,
              child: Text(
                'Notes',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            10.verticalSpace,
            ViewNotes(
              notes: mybook.notes,
            ),
          ],
        ),
      ),
    );
  }
}
