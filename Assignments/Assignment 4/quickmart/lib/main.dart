import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickmart/routes/app_router.dart';

void main() {
  runApp(MyApp());
}

late FToast fToast;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'QuickMart',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            primary: Colors.blue, // Primary color for AppBar
            // Secondary color
            secondary: Colors.blue[200],
            surface: Colors.white, // Surface color for cards
            error: Colors.red,
            onPrimary: Colors.white, // Text color on AppBar
            onSecondary: Colors.white,
            onSurface: Colors.black, // Text color on surface
            onError: Colors.white,
          ),
          appBarTheme: AppBarTheme(
            foregroundColor: Colors.white, // Text and icon color on AppBar
          ),
          scaffoldBackgroundColor: Colors.white, // Scaffold background color
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white, // Bottom navigation bar background
            selectedItemColor: Colors.blue, // Selected item color
            unselectedItemColor: Colors.grey, // Unselected item color
          ),
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.black), // Default text color
            bodyMedium:
                TextStyle(color: Colors.black54), // Secondary text color
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
