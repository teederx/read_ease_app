import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/app_colors.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    required this.dataEntry,
    this.entry,
  });
  final DataEntry dataEntry;
  final String? entry;

  @override
  Widget build(BuildContext context) {
    return switch (dataEntry) {
      DataEntry.noBook => dataMethod(
          'You do not have a book registered. Tap  the \'Add Book\' button to register a book!',
        ),
      DataEntry.noNote => dataMethod(
          'No note entered for this book yet. Tap the pen icon on the top right corner to add a new note!',
        ),
      DataEntry.noBookTitle =>
        dataMethod('Could not find book with the entry \'$entry\'!!'),
      DataEntry.noBookCompleted => dataMethod(
          'You have not finished reading any book. Tap the \'Mark as Finshed\' button to register a book as completed!',
        ),
      DataEntry.noBookActive => dataMethod(
          'You are not currently reading any book. Add a book to start reading!',
        ),
      DataEntry.noFavorite => dataMethod(
          'You are currently have no book registered as favorite. Tap the favorite Icon to register a book as favorite!',
        ),
    };
  }

  ListView dataMethod(String description) {
    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          'Oops!!',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
          ),
        ),
        Text(
          description,
          style: const TextStyle(
            color: AppColors.secondaryColor2,
          ),
        ),
        10.verticalSpace,
        Lottie.asset('assets/gif/no_data.json'),
      ],
    );
  }
}

enum DataEntry {
  noBook,
  noNote,
  noBookCompleted,
  noBookActive,
  noBookTitle,
  noFavorite,
}
