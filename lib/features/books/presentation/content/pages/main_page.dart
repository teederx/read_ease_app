import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:read_ease_app/core/constants/app_colors.dart';
import 'package:read_ease_app/features/books/presentation/content/widgets/favorites.dart';
import 'package:read_ease_app/features/books/presentation/content/widgets/home.dart';
import 'package:read_ease_app/features/books/presentation/content/widgets/search.dart';

import '../../../../../config/router/route.dart';
import '../widgets/my_bottom_bar.dart';
import '../widgets/my_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
                  : 'Favorites',
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
              height:  25.h,
              width: 25.w,
            ),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          Home(),
          Search(),
          Favorites(),
        ],
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.goNamed(RouteNames.addNewBook),
        label: const Text('Add Book'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: MyBottomBar(
        selectedIndex: _selectedIndex,
        selectIndex: selectIndex,
      ),
    );
  }
}
