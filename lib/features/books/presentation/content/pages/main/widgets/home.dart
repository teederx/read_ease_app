import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:read_ease_app/core/constants/app_colors.dart';
import 'package:read_ease_app/core/utils/app_padding.dart';

import '../../../../../../../config/router/route_names.dart';
import '../../../../../data/models/book/book.dart';
import '../../../../../data/models/custom_error/custom_error.dart';
import '../../../../../data/usecases_providers/user/user_usecase_provider.dart';
import '../../../widgets/my_books_list.dart';
import '../../../widgets/no_data.dart';

class Home extends ConsumerWidget {
  const Home({
    super.key,
    required this.bookListState,
  });

  final AsyncValue<List<Book>> bookListState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userUsecaseProvider).getUser();

    return Scaffold(
      body: AppPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${user!.name}',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              ),
            ),
            6.verticalSpace,
            Text(
              'Books are portals to perspectives, adventures, and wisdom beyond your own. Reading isn\'t just a pastime; it\'s an act of growth.',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 13.sp,
                color: AppColors.secondaryColor2,
              ),
            ),
            Text(
              'So let\'s get right into it then.',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 13.sp,
                color: AppColors.secondaryColor2,
              ),
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Collections',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => context.goNamed(RouteNames.addNewBook),
                  style: TextButton.styleFrom(
                    elevation: 2,
                    shadowColor: AppColors.secondaryColor2,
                    backgroundColor: AppColors.secondaryColor,
                    foregroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  label: const Text(
                    'Add Book',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            10.verticalSpace,
            Expanded(
              child: bookListState.when(
                data: (List<Book> book) {
                  if (book.isEmpty) {
                    return const NoData(
                      dataEntry: DataEntry.noBook,
                    );
                  }
                  return MyBooksList(
                    ref: ref,
                    books: book,
                  );
                },
                error: (e, st) {
                  final error = e as CustomError;
                  return Center(
                    child: Text(
                      'code: ${error.code}\nplugin: ${error.plugin}\nmessage: ${error.message}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
