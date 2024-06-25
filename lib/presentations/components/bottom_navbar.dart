/// Documentation
///
/// bottom_navbar_with_indicator library.
// ignore_for_file: non_constant_identifier_names

library bottom_navbar_with_indicator;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Documentation
///
/// enum's for indicator type.
enum IndicatorType { top, bottom }

/// Documentation
///
/// customer line indicator bottom navigation bar class.
class CustomLineIndicatorBottomNavbar extends StatelessWidget {
  final Color? backgroundColor;
  final List<CustomBottomBarItems> customBottomBarItems;
  final Color? selectedColor;
  final Color? unSelectedColor;
  final double unselectedFontSize;
  final Color? splashColor;
  final int currentIndex;
  final bool enableLineIndicator;
  final double lineIndicatorWidth;
  final IndicatorType indicatorType;
  final Function(int) onTap;
  final double selectedFontSize;
  final double selectedIconSize;
  final double unselectedIconSize;
  final LinearGradient? gradient;

  const CustomLineIndicatorBottomNavbar({
    super.key,
    this.backgroundColor,
    this.selectedColor,
    required this.customBottomBarItems,
    this.unSelectedColor,
    this.unselectedFontSize = 11,
    this.selectedFontSize = 12,
    this.selectedIconSize = 20,
    this.unselectedIconSize = 15,
    this.splashColor,
    this.currentIndex = 0,
    required this.onTap,
    this.enableLineIndicator = true,
    this.lineIndicatorWidth = 3,
    this.indicatorType = IndicatorType.top,
    this.gradient,
  });

  /// body of nav bar.
  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarThemeData bottomTheme = BottomNavigationBarTheme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? bottomTheme.backgroundColor,
        gradient: gradient,
      ),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < customBottomBarItems.length; i++) ...[
              Expanded(
                child: CustomLineIndicatorBottomNavbarItems(
                  selectedColor: selectedColor,
                  unSelectedColor: unSelectedColor,
                  icon_active: customBottomBarItems[i].icon_active,
                  icon_inactive: customBottomBarItems[i].icon_inactive,
                  label: customBottomBarItems[i].label,
                  unSelectedFontSize: unselectedFontSize,
                  selectedFontSize: selectedFontSize,
                  unselectedIconSize: unselectedIconSize,
                  selectedIconSize: selectedIconSize,
                  splashColor: splashColor,
                  currentIndex: currentIndex,
                  enableLineIndicator: enableLineIndicator,
                  lineIndicatorWidth: lineIndicatorWidth,
                  indicatorType: indicatorType,
                  index: i,
                  onTap: onTap,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

/// Documentation
///
/// custom bottom bar items model.
class CustomBottomBarItems {
  /// pass icon with type IconData
  final String? icon_active;
  final String? icon_inactive;

  /// pass label with type .
  final String label;

  CustomBottomBarItems({
    required this.icon_active,
    required this.icon_inactive,
    required this.label,
  });
}

/// Documentation
///
/// custom line indicator bottom navbar items stateless widget.
class CustomLineIndicatorBottomNavbarItems extends StatelessWidget {
  /// pass icon with type IconData
  final String? icon_active;
  final String? icon_inactive;

  /// pass label with type .
  final String? label;
  final Color? selectedColor;
  final Color? unSelectedColor;
  final double unSelectedFontSize;
  final double selectedIconSize;
  final double unselectedIconSize;
  final double selectedFontSize;
  final Color? splashColor;
  final int? currentIndex;
  final int index;
  final Function(int) onTap;
  final bool enableLineIndicator;
  final double lineIndicatorWidth;
  final IndicatorType indicatorType;

  const CustomLineIndicatorBottomNavbarItems({
    super.key,
    this.icon_active,
    this.icon_inactive,
    this.label,
    this.selectedColor,
    this.unSelectedColor,
    this.unSelectedFontSize = 11,
    this.selectedFontSize = 12,
    this.selectedIconSize = 20,
    this.unselectedIconSize = 15,
    this.splashColor,
    this.currentIndex,
    required this.onTap,
    required this.index,
    this.enableLineIndicator = true,
    this.lineIndicatorWidth = 3,
    this.indicatorType = IndicatorType.top,
  });

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarThemeData bottomTheme = BottomNavigationBarTheme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 7),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: splashColor ?? Theme.of(context).splashColor,
            onTap: () {
              onTap(index);
            },
            child: Container(
              // decoration: BoxDecoration(
              //   border: enableLineIndicator
              //       ? Border(
              //           bottom: indicatorType == IndicatorType.bottom
              //               ? BorderSide(
              //                   color: currentIndex == index ? Colors.blue : Colors.transparent,
              //                   width: lineIndicatorWidth,
              //                 )
              //               : const BorderSide(color: Colors.transparent),
              //           top: indicatorType == IndicatorType.top
              //               ? BorderSide(
              //                   color: currentIndex == index ? Colors.blue : Colors.transparent,
              //                   width: lineIndicatorWidth,
              //                 )
              //               : const BorderSide(color: Colors.transparent),
              //         )
              //       : null,
              //  ),
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              // width: 70,
              // height: 60,
              child: Column(
                children: [
                  SvgPicture.asset(
                    currentIndex == index ? icon_active! : icon_inactive!,
                    height: 24,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '$label',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: currentIndex == index ? selectedFontSize : unSelectedFontSize,
                      color: currentIndex == index ? selectedColor ?? bottomTheme.unselectedItemColor : unSelectedColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
