import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GymTech',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(
            AppColors.primaryColor.value,
            <int, Color>{
              50: AppColors.primaryColor,
              100: AppColors.primaryColor,
              200: AppColors.primaryColor,
              300: AppColors.primaryColor,
              400: AppColors.primaryColor,
              500: AppColors.primaryColor,
              600: AppColors.primaryColor,
              700: AppColors.primaryColor,
              800: AppColors.primaryColor,
              900: AppColors.primaryColor,
            },
          ),
        ).copyWith(
          secondary: AppColors.secondaryColor,
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor, // Remplacé par scaffoldBackgroundColor
        fontFamily: 'Teko',
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            color: AppColors.textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle( // Remplacé par bodyMedium
            color: AppColors.textColor,
            fontSize: 16,
          ),
        ),
      ),
      home: isLoggedIn ? HomeScreen() : LoginScreen(),
    );
  }
}