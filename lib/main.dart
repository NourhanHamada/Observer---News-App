import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:observer/constants/colors.dart';
import 'package:observer/constants/icons.dart';
import 'package:observer/view/components/layOut.dart';
import 'package:observer/view/screens/bookmark_screen.dart';
import 'package:observer/view/screens/explore_screen.dart';
import 'package:observer/view/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:observer/view/screens/interesting_screen.dart';
import 'package:observer/view/screens/news_details_screen.dart';
import 'package:observer/view/screens/onboard_screen.dart';
import 'package:observer/view/screens/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/homeScreen': (context) => const HomeScreen(),
        '/layoutScreen': (context) => LayOut(),
        '/interestingScreen': (context) => InterestingScreen(),
        '/exploreScreen': (context) => ExploreScreen(),
        '/bookmarkScreen': (context) => BookmarkScreen(),
        '/detailsScreen': (context) => NewDetailsScreen(),
        '/searchScreen' : (context) => SearchScreen(),
      },
      title: 'Observer',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: whiteColor,
        iconTheme: const IconThemeData(),
        iconButtonTheme: const IconButtonThemeData(),
        splashColor: whiteColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(
              bodyColor: mainColor,
            )
            .copyWith(
              headlineLarge: const TextStyle(
                fontSize: 20,
              ),
              headlineMedium: const TextStyle(),
              headlineSmall: const TextStyle(),
              bodyLarge: TextStyle(),
              bodyMedium: TextStyle(),
              bodySmall: TextStyle(),
            ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: AnimatedSplashScreen(
        splash: logoLarge,
        nextScreen:
        // OnboardScreen(),
        isViewed != 0 ? OnboardScreen() : LayOut(),
        centered: true,
        duration: 3000,
      ),
    );
  }
}
// Dear programmer
// When I wrote this code, only god and
// I knew how it worked
// Now, only god know it!
//
// Therefor, if you are trying to optimize
// this routine and it fails (most surely),
// Please increase this counter as a
// warning for next person:

// total_hours_wasted_here = 254
//
