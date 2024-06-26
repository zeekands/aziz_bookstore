import 'package:aziz_bookstore/core/extentions/navigator_extentions.dart';
import 'package:aziz_bookstore/core/extentions/theme_extention.dart';
import 'package:aziz_bookstore/core/extentions/widget_extentions.dart';
import 'package:aziz_bookstore/core/routes/app_paths.dart';
import 'package:aziz_bookstore/core/theme/colors.dart';
import 'package:aziz_bookstore/core/theme/status_bar_color.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    lightStatusBar();
    return Scaffold(
      backgroundColor: cMainPurple,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/welcome_image.png'),
            Text(
              'Read Your\nfavourite book\nFrom here.',
              style: context.headline2TextStyle?.copyWith(
                color: cMainWhite,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Discover and search your new journey through amazing and wonderful books! All for free.",
              style: context.bodyText1TextStyle?.copyWith(color: cMainWhite, fontSize: 13),
            ),
            ElevatedButton(
              onPressed: () {
                context.pushReplacementNamed(AppPaths.home);
              },
              child: Text(
                'Get Started',
                style: context.bodyText1TextStyle?.copyWith(color: cMainWhite, fontSize: 13),
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 20).paddingOnly(top: 20),
      ),
    );
  }
}
