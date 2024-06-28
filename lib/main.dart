import 'package:aziz_bookstore/core/constants/env.dart';
import 'package:aziz_bookstore/core/injection/di.dart';
import 'package:aziz_bookstore/core/routes/app_routes.dart';
import 'package:aziz_bookstore/core/services/bloc_provider.dart';
import 'package:aziz_bookstore/core/services/network_service.dart';
import 'package:aziz_bookstore/core/theme/colors.dart';
import 'package:aziz_bookstore/presentations/pages/welcome_page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

final GlobalKey<ScaffoldState> key = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await dotenv.load(fileName: ".env");
  httpService.setBaseUrl(baseUrl);
  Gemini.init(apiKey: geminiKey);

  runApp(
    MultiBlocProvider(
      providers: BlocProviders.getproviders,
      child: MaterialApp(
        title: 'Flutter Demo',
        key: key,
        debugShowCheckedModeBanner: false,
        routes: appRoutes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: cMainWhite,
          fontFamily: 'PlusJakartaSans',
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.white,
            centerTitle: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: cButtonColor,
              padding: const EdgeInsets.all(0),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: cButtonColor,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: cMainWhite,
              ),
            ),
          ),
        ),
        home: const WelcomePage(),
      ),
    ),
  );
}
