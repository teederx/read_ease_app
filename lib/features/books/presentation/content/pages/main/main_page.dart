import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:read_ease_app/core/constants/app_colors.dart';
import 'package:read_ease_app/features/books/presentation/content/providers/book_list_provider/book_list_provider.dart';
import 'package:read_ease_app/features/books/presentation/content/pages/main/widgets/home.dart';
import 'package:read_ease_app/features/books/presentation/content/pages/main/widgets/search/search.dart';

import '../../../../../../config/router/route.dart';
import '../../../../data/models/book/book.dart';
import 'widgets/active_page.dart';
import 'widgets/completed_page.dart';
import 'widgets/my_bottom_bar.dart';
import 'widgets/my_drawer.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void selectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    _pageController.addListener(
      () => setState(() {
        _selectedIndex = _pageController.page!.round();
      }),
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<List<Book>>>(
      bookListProvider,
      (prev, next) {
        if (!next.isLoading) {
          //'whenOrNull' this is used when you want to handle only one condition
          next.whenOrNull(
            error: (error, stackTrace) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog.adaptive(
                  title: const Text(
                    'Error',
                    textAlign: TextAlign.center,
                  ),
                  content: Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          );
        }
      },
    );

    final bookListState = ref.watch(bookListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: SvgPicture.asset(
              'assets/icons/menu.svg',
            ),
          );
        }),
        centerTitle: true,
        title: Text(
          _selectedIndex == 0
              ? 'Read Ease'
              : _selectedIndex == 1
                  ? 'Search'
                  : _selectedIndex == 2
                      ? 'Active'
                      : 'Completed',
        ),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
          color: AppColors.primaryColor,
          height: 2.h,
        ),
        actions: [
          IconButton(
            onPressed: () => context.goNamed(RouteNames.settings),
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              height: 25.h,
              width: 25.w,
            ),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          Home(
            bookListState: bookListState,
          ),
          Search(
            bookListState: bookListState,
          ),
          ActivePage(
            bookListState: bookListState,
          ),
          CompletedPage(
            bookListState: bookListState,
          ),
        ],
      ),
      drawer: MyDrawer(
        bookListState: bookListState,
      ),
      bottomNavigationBar: MyBottomBar(
        selectedIndex: _selectedIndex,
        selectIndex: selectIndex,
      ),
    );
  }
}
