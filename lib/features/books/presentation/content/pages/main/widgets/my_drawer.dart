import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:read_ease_app/core/constants/app_colors.dart';
import 'package:read_ease_app/features/books/data/usecases_providers/auth/auth_use_case_provider.dart';
import 'package:read_ease_app/features/books/data/usecases_providers/user/user_usecase_provider.dart';

import '../../../../../../../config/router/route.dart';
import '../../../../../data/models/book/book.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({
    super.key,
    required this.bookListState,
  });
  final AsyncValue<List<Book>> bookListState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userUsecaseProvider).getUser();
    final completedNum =
        bookListState.value!.where((book) => book.isCompleted).toList().length;
    final totalNum = bookListState.value!.length;

    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
              vertical: 20.h,
            ),
            color: AppColors.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.r,
                  backgroundColor: AppColors.secondaryColor,
                  child: Icon(
                    Icons.person_outline_rounded,
                    size: 60.r,
                  ),
                ),
                10.verticalSpace,
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    user!.name.isNotEmpty ? user.name : 'name',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.secondaryColor,
                      fontSize: 30.sp,
                    ),
                  ),
                ),
                5.verticalSpace,
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: AppColors.secondaryColor1,
                      ),
                    ),
                    5.horizontalSpace,
                    Text(
                      'PROGRESS: $completedNum OF $totalNum',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondaryColor1,
                        fontSize: 15.sp,
                        letterSpacing: 3,
                      ),
                    ),
                    5.horizontalSpace,
                    const Expanded(
                      child: Divider(
                        color: AppColors.secondaryColor1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/mail.svg',
              height: 25.h,
              width: 25.w,
            ),
            title: Text(
              user.email.isNotEmpty ? user.email : 'email',
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/favorites.svg',
              height: 25.h,
              width: 25.w,
            ),
            title: const Text(
              'My favorite books',
            ),
            onTap: () {
              Navigator.pop(context);
              context.pushNamed(
                RouteNames.favorite,
              );
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/logout.svg',
              height: 25.h,
              width: 25.w,
            ),
            title: const Text(
              'Logout',
            ),
            onTap: () async {
              //sync user data to cloud
              await ref.read(authUseCaseProvider).syncProfileToCloud();
              //Logout user
              await ref.read(authUseCaseProvider).signOut();
              //delete user from local database to save space
              await ref.read(userUsecaseProvider).deleteUser();
            },
          ),
        ],
      ),
    );
  }
}
