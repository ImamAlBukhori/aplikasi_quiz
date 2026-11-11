import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/category_card.dart';
import '../../widgets/app_card.dart';
import '../profile/profile_screen.dart';
import '../leaderboard/leaderboard_screen.dart';
import '../quiz/quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({
    super.key,
    required this.userName,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const lime = Color(0xFFB7F34A);

  late String userName;

  @override
  void initState() {
    super.initState();
    userName = widget.userName;
  }

  // Memuat ulang nama pengguna dari SharedPreferences.
  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      userName = prefs.getString('user_name') ?? 'Football Player';
    });
  }

  // Membuka halaman Profile dan memperbarui nama setelah kembali.
  Future<void> _openProfile() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfileScreen(),
      ),
    );

    if (!mounted) return;

    await _loadUserName();
  }

  void _startQuiz(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(
          category: category,
          playerName: userName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'Piala Dunia',
        'subtitle': 'Uji pengetahuan tentang World Cup',
        'icon': Icons.public,
      },
      {
        'title': 'Liga Champions',
        'subtitle': 'Kenali sejarah kompetisi Eropa',
        'icon': Icons.emoji_events,
      },
      {
        'title': 'Pemain Legendaris',
        'subtitle': 'Tebak pemain terbaik dunia',
        'icon': Icons.sports_soccer,
      },
      {
        'title': 'Sepak Bola Umum',
        'subtitle': 'Uji wawasan sepak bola kamu',
        'icon': Icons.stadium,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF101517),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding =
            constraints.maxWidth > 600 ? 40.0 : 20.0;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 650),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: lime,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.sports_soccer,
                              color: Color(0xFF101517),
                              size: 29,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'FootQuiz',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                              Text(
                                'Football Knowledge Game',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            tooltip: 'Leaderboard',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const LeaderboardScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.leaderboard_outlined,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            tooltip: 'Profile',
                            onPressed: _openProfile,
                            icon: const Icon(
                              Icons.account_circle_outlined,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      Text(
                        'Halo, $userName!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 7),

                      const Text(
                        'Siap menguji pengetahuan sepak bola kamu?',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 25),

                      AppCard(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.emoji_events,
                                  color: lime,
                                  size: 28,
                                ),
                                SizedBox(width: 9),
                                Text(
                                  'CHALLENGE YOURSELF',
                                  style: TextStyle(
                                    color: lime,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 17),

                            const Text(
                              'Seberapa jago\nkamu tentang bola?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                height: 1.3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              'Jawab pertanyaan, kumpulkan poin, dan buktikan wawasan sepak bola kamu!',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),

                            const SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () => _startQuiz(
                                  context,
                                  'Semua Kategori',
                                ),
                                icon: const Icon(Icons.play_arrow),
                                label: const Text('MULAI QUIZ'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: lime,
                                  foregroundColor:
                                  const Color(0xFF101517),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(13),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        'Pilih Kategori',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 14),

                      ...categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CategoryCard(
                            title: category['title'] as String,
                            subtitle: category['subtitle'] as String,
                            icon: category['icon'] as IconData,
                            onTap: () => _startQuiz(
                              context,
                              category['title'] as String,
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 20),

                      const Center(
                        child: Text(
                          'FOOTQUIZ • PLAY. LEARN. WIN.',
                          style: TextStyle(
                            color: Colors.white30,
                            fontSize: 10,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
