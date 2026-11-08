import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/auth/login_screen.dart';

void main() {
  runApp(const FootQuizApp());
}

class FootQuizApp extends StatelessWidget {
  const FootQuizApp({super.key});

  @override
  Widget build(BuildCont1ext context) {
    return MaterialApp(
      title: 'FootQuiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF101517),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB7F34A),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF101517),
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
