import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_ease_app/core/constants/app_colors.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.passwordController,
    required this.isVisible,
    required this.onPressed,
  });
  final TextEditingController passwordController;
  final bool isVisible;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Password',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        6.verticalSpace,
        TextFormField(
          controller: passwordController,
          obscureText: isVisible ? false : true,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            filled: true,
            hintText: 'Enter your password',
            hintStyle: TextStyle(
              color: AppColors.secondaryColor2,
              fontWeight: FontWeight.w300,
              fontSize: 14.sp,
            ),
            fillColor: AppColors.secondaryColor1,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: isVisible
                  ? const Icon(Icons.visibility_off_outlined)
                  : const Icon(Icons.visibility_outlined),
            ),
            suffixIconColor: AppColors.secondaryColor2,
          ),
          validator: (value) {
            if (value!.length < 6) {
              return 'Password must be atleast 6 chars long';
            }
            return null;
          },
        ),
      ],
    );
  }
}
