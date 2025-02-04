import 'package:flutter/material.dart';

import '../../../../../../../core/constants/app_colors.dart';

class CompletedButton extends StatelessWidget {
  const CompletedButton({
    super.key,
    this.onPressed,
    required this.isCompleted,
  });

  final void Function()? onPressed;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: AppColors.secondaryColor,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: AppColors.secondaryColor2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        label: Text(isCompleted ? 'Mark as Unfinished' : 'Mark as Finished'),
        icon: Icon(
          isCompleted ? Icons.close_rounded : Icons.done_outline_rounded,
          color: isCompleted ? AppColors.iconRedColor : AppColors.primaryColor,
        ),
      ),
    );
  }
}
