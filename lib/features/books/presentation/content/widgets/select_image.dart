import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/app_colors.dart';

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
