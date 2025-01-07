import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';

class NameField extends StatelessWidget {
  const NameField({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Name',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        6.verticalSpace,
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            filled: true,
            hintText: 'Enter your name',
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
          validator: (value){
            if(value!.length < 3){
              return 'Name must be atleast 3 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}
