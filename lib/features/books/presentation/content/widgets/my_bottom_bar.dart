import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/app_colors.dart';

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({
    super.key,
    required this.selectedIndex,
    required this.selectIndex,
  });

  final int selectedIndex;
  final Function selectIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 80.h,
      color: Colors.transparent,
      child: Card(
        elevation: 5,
        color: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          margin: EdgeInsets.all(2.r),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => selectIndex(0),
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  height: selectedIndex == 0 ? 25.h : 20.h,
                  width: selectedIndex == 0 ? 25.w : 20.w,
                  colorFilter: ColorFilter.mode(
                    selectedIndex == 0
                        ? AppColors.primaryColor
                        : AppColors.iconBlack,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => selectIndex(1),
                icon: SvgPicture.asset(
                  'assets/icons/search.svg',
                  height: selectedIndex == 1 ? 25.h : 20.h,
                  width: selectedIndex == 1 ? 25.w : 20.w,
                  colorFilter: ColorFilter.mode(
                    selectedIndex == 1
                        ? AppColors.primaryColor
                        : AppColors.iconBlack,
                    BlendMode.srcIn,
                  ),
                ),
              ), //search
              IconButton(
                onPressed: () => selectIndex(2),
                icon: SvgPicture.asset(
                  'assets/icons/favorites.svg',
                  height: selectedIndex == 2 ? 25.h : 20.h,
                  width: selectedIndex == 2 ? 25.w : 20.w,
                  colorFilter: ColorFilter.mode(
                    selectedIndex == 2
                        ? AppColors.primaryColor
                        : AppColors.iconBlack,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
