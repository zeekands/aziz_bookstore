import 'package:aziz_bookstore/core/theme/colors.dart';
import 'package:aziz_bookstore/core/theme/status_bar_color.dart';
import 'package:aziz_bookstore/data/datasources/local_data_source/db_helper.dart';
import 'package:aziz_bookstore/presentations/components/bottom_navbar.dart';
import 'package:aziz_bookstore/presentations/pages/explore_page/explore_page.dart';
import 'package:aziz_bookstore/presentations/pages/home/home_page.dart';
import 'package:aziz_bookstore/presentations/pages/liked_page/liked_page.dart';
import 'package:flutter/material.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> with AutomaticKeepAliveClientMixin {
  int _selected = 0;
  final transitionDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    darkStatusBar();
    return Scaffold(
      body: IndexedStack(
        index: _selected,
        children: [
          HomePage(
            goToExplorePage: () {
              setState(
                () {
                  _selected = 1;
                },
              );
            },
          ),
          const ExplorePage(),
          const LikedPage(),
        ],
      ),
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        selectedColor: cMainPurple,
        unSelectedColor: Colors.black54,
        backgroundColor: Colors.white,
        currentIndex: _selected,
        unselectedIconSize: 15,
        selectedIconSize: 20,
        onTap: (index) {
          setState(() {
            _selected = index;
            getLikedBooks();
          });
        },
        enableLineIndicator: true,
        lineIndicatorWidth: 3,
        indicatorType: IndicatorType.top,
        customBottomBarItems: [
          CustomBottomBarItems(
              label: 'Home',
              icon_active: 'assets/icons/ic_home_active.svg',
              icon_inactive: 'assets/icons/ic_home_inactive.svg'),
          CustomBottomBarItems(
              label: 'Explore',
              icon_active: 'assets/icons/ic_explore_active.svg',
              icon_inactive: 'assets/icons/ic_explore_inactive.svg'),
          CustomBottomBarItems(
              label: 'Liked',
              icon_active: 'assets/icons/ic_liked_active.svg',
              icon_inactive: 'assets/icons/ic_liked_inactive.svg'),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
