import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:read_ease_app/config/router/route.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/book/book.dart';
import '../providers/book_list_provider/book_list_provider.dart';

class MyBooksList extends StatefulWidget {
  const MyBooksList({
    super.key,
    required this.ref,
    required this.books,
  });

  final WidgetRef ref;
  final List<Book> books;

  @override
  State<MyBooksList> createState() => _MyBooksListState();
}

class _MyBooksListState extends State<MyBooksList> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 0.5,
      controller: _scrollController,
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          reverse: true,
          itemBuilder: (context, index) {
            final myBook = widget.books[index];
            final bookID = myBook.bookID;
            final image = myBook.imageURL;
            return Stack(
              children: [
                ListTile(
                  onLongPress: () {
                    context.goNamed(
                      RouteNames.editBook,
                      extra: myBook.bookID,
                    );
                  },
                  onTap: () {
                    context.goNamed(
                      RouteNames.viewBook,
                      extra: myBook.bookID,
                    );
                  },
                  isThreeLine: true,
                  leading: Container(
                    height: 60.h,
                    width: 55.w,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor1,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: image == ''
                        ? SvgPicture.asset(
                            'assets/icons/book.svg',
                            fit: BoxFit.fill,
                          )
                        : Image.memory(
                            base64Decode(image),
                            fit: BoxFit.fill,
                          ),
                  ),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          myBook.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Author: ${myBook.author}',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      5.verticalSpace,
                      Text(
                        myBook.desc,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      IconButton(
                        onPressed: () => widget.ref
                            .read(bookListProvider.notifier)
                            .toggleFavorite(bookId: bookID),
                        icon: Icon(
                          widget.books[index].isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (myBook.isCompleted)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(3.r),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            bottomLeft: Radius.circular(10.r),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/bookmark.svg',
                            height: 15.h,
                            width: 15.w,
                            colorFilter: const ColorFilter.mode(
                              AppColors.secondaryColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          Text(
                            'completed',
                            style: TextStyle(
                                color: AppColors.secondaryColor, fontSize: 13.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
          separatorBuilder: (context, _) => const Divider(),
          itemCount: widget.books.length,
        )..reverse,
      ),
    );
  }
}
