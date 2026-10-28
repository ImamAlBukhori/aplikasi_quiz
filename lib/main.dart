import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FootQuizApp());
}

class FootQuizApp extends StatelessWidget {
  const FootQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      home: const FootQuizHome(),
    );
  }
}

class FootQuizHome extends StatelessWidget {
  const FootQuizHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB7F34A),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.sports_soccer,
                      size: 58,
                      color: Color(0xFF172014),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'FOOTQUIZ',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FOOTBALL KNOWLEDGE CHALLENGE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.5,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B2425),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFF354039),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '⚽ 🏆 ⭐',
                          style: TextStyle(fontSize: 34),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Uji Wawasan Sepak Bolamu!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Jawab pertanyaan, kumpulkan poin, '
                              'dan jadilah legenda di papan peringkat!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.6,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Halaman login akan dibuat pada tahap berikutnya!',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.play_arrow_rounded),
                            label: const Text('MULAI PETUALANGAN'),
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFFB7F34A),
                              foregroundColor: const Color(0xFF172014),
                              padding: const EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'THINK FAST. PLAY SMART. WIN BIG.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 10,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w700,
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
