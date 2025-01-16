import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPadding extends StatelessWidget {
  final Widget child;
  const AppPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 25.w,
      ),
      child: child,
    );
  }
}
