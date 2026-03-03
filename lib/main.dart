import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/meteo_provider.dart';
import 'screens/home/home_screen.dart';
import 'screens/main_screen/main_screen.dart';

// Thème sombre
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF00B4D8),
    secondary: Color(0xFF0077B6),
    surface: Color(0xFF1A1A2E),
    onSurface: Colors.white,
  ),
  scaffoldBackgroundColor: const Color(0xFF0F0F1A),
);

// Thème clair
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF0077B6),
    secondary: Color(0xFF00B4D8),
    surface: Colors.white,
    onSurface: Color(0xFF212121),
  ),
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
);

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MeteoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Météo Progress',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: const HomeScreen(),
          routes: {
            '/home': (context) => const HomeScreen(),
            '/main': (context) => const MainScreen(),
            // P3 : ajouter '/city_detail' ici
          },
        );
      },
    );
  }
}
