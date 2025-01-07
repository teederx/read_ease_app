import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.emailController,
  });
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Email address',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        6.verticalSpace,
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            filled: true,
            hintText: 'Enter your email',
            hintStyle: TextStyle(
              color: AppColors.secondaryColor2,
              fontWeight: FontWeight.w300,
              fontSize: 14.sp,
            ),
            fillColor: AppColors.secondaryColor1,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );
  }
}
