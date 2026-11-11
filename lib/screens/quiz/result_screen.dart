import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../widgets/primary_button.dart';
import '../home/home_screen.dart';
import '../leaderboard/leaderboard_screen.dart';

class ResultScreen extends StatefulWidget {
  final String playerName;
  final String category;
  final int score;
  final int correct;
  final int total;

  const ResultScreen({
    super.key,
    required this.playerName,
    required this.category,
    required this.score,
    required this.correct,
    required this.total,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late final ConfettiController _confettiController;

  static const lime = Color(0xFFB7F34A);

  double get accuracy =>
      widget.total == 0 ? 0 : widget.correct / widget.total * 100;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  String get resultTitle {
    if (accuracy >= 80) return 'Luar Biasa!';
    if (accuracy >= 60) return 'Kerja Bagus!';
    if (accuracy >= 40) return 'Cukup Baik!';
    return 'Tetap Semangat!';
  }

  String get resultDescription {
    if (accuracy >= 80) {
      return 'Wawasan sepak bola kamu sangat hebat. Pertahankan!';
    }
    if (accuracy >= 60) {
      return 'Kamu sudah cukup menguasai sepak bola. Terus berlatih!';
    }
    if (accuracy >= 40) {
      return 'Masih ada yang perlu dipelajari. Coba lagi!';
    }
    return 'Jangan menyerah. Setiap permainan adalah kesempatan belajar!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101517),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: lime,
                        size: 85,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        resultTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 29,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        resultDescription,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white60,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 30),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B2425),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'TOTAL SCORE',
                              style: TextStyle(
                                color: Colors.white54,
                                letterSpacing: 2,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${widget.score}',
                              style: const TextStyle(
                                color: lime,
                                fontSize: 54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'POINTS',
                              style: TextStyle(
                                color: Colors.white54,
                                letterSpacing: 2,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 25),
                            const Divider(color: Colors.white12),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                _stat(
                                  'Benar',
                                  '${widget.correct}/${widget.total}',
                                  Icons.check_circle,
                                ),
                                _stat(
                                  'Akurasi',
                                  '${accuracy.toStringAsFixed(0)}%',
                                  Icons.track_changes,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                      Text(
                        'Kategori: ${widget.category}',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 30),

                      PrimaryButton(
                        text: 'MAIN LAGI',
                        icon: Icons.refresh,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HomeScreen(
                                userName: widget.playerName,
                              ),
                            ),
                                (route) => false,
                          );
                        },
                      ),
                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const LeaderboardScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.leaderboard),
                          label: const Text('LIHAT LEADERBOARD'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: lime,
                            side: const BorderSide(color: lime),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                numberOfParticles: 18,
                maxBlastForce: 25,
                minBlastForce: 8,
                gravity: 0.2,
                shouldLoop: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: lime, size: 25),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
