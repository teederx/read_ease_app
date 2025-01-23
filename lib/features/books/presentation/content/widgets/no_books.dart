import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/app_colors.dart';

class NoBooks extends StatelessWidget {
  const NoBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        const Text(
          'You do not have a book registered. Click the \'Add Book\' button to register a book',
        ),
        10.verticalSpace,
        Lottie.asset('assets/gif/no_data.json'),
      ],
    );
  }
}
