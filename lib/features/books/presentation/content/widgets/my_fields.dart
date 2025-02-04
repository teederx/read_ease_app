import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';

class MyFields extends StatelessWidget {
  const MyFields({
    super.key,
    this.maxLines = 1,
    this.maxLength,
    required this.title,
    required this.controller,
    required this.hintText,
    this.validator,
    this.textInputAction,
  });

  final String title;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final int? maxLength;

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
          textInputAction: textInputAction,
          maxLines: maxLines,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
