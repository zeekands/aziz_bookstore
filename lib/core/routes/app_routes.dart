import 'package:aziz_bookstore/core/routes/app_paths.dart';
import 'package:aziz_bookstore/presentations/pages/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:aziz_bookstore/presentations/pages/detail_page/detail_page.dart';
import 'package:aziz_bookstore/presentations/pages/see_all/see_all_page.dart';
import 'package:aziz_bookstore/presentations/pages/welcome_page/welcome_page.dart';

final appRoutes = {
  AppPaths.home: (context) => const BottomNavBarPage(),
  AppPaths.welcome: (context) => const WelcomePage(),
  AppPaths.bookDetail: (context) => const DetailPage(),
  AppPaths.seeAll: (context) => const SeeAllPage(),
};
