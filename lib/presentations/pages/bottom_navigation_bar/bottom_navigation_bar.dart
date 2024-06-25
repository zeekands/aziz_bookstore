import 'package:aziz_bookstore/core/theme/colors.dart';
import 'package:aziz_bookstore/core/theme/status_bar_color.dart';
import 'package:aziz_bookstore/presentations/components/bottom_navbar.dart';
import 'package:aziz_bookstore/presentations/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> with AutomaticKeepAliveClientMixin {
  int _selected = 0;
  final transitionDuration = const Duration(milliseconds: 200);

  final PageController _pageController = PageController(initialPage: 0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    darkStatusBar();
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) {
            setState(() => _selected = index);
          },
          children: [
            const HomePage(),
            Container(),
            Container(),
            Container(),
          ],
        ),
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
            _pageController.jumpToPage(
              index,
            );
            _selected = index;
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
              label: 'Promo',
              icon_active: 'assets/icons/ic_explore_active.svg',
              icon_inactive: 'assets/icons/ic_explore_inactive.svg'),
          CustomBottomBarItems(
              label: 'Kategori',
              icon_active: 'assets/icons/ic_liked_active.svg',
              icon_inactive: 'assets/icons/ic_liked_inactive.svg'),
          CustomBottomBarItems(
            label: 'Wishlist',
            icon_active: 'assets/icons/ic_profile_active.svg',
            icon_inactive: 'assets/icons/ic_profile_inactive.svg',
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class IconBottomBar extends StatelessWidget {
  final String name;
  final String iconActive;
  final String iconInactive;
  final bool selected;
  final Function() onPressed;

  const IconBottomBar(
      {super.key,
      required this.name,
      required this.iconActive,
      required this.iconInactive,
      required this.selected,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(children: [
        Positioned(
          top: -4,
          child: Container(
            height: 5,
            width: 50,
            color: Colors.blue,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              selected ? iconActive : iconInactive,
              height: 24,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: TextStyle(
                color: selected ? Colors.red : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            )
          ],
        ),
      ]),
    );
  }
}
