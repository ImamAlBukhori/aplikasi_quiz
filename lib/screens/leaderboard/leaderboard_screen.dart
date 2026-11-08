import 'package:flutter/material.dart';
import '../../services/storage_service.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() =>
      _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  static const lime = Color(0xFFB7F34A);

  List<Map<String, dynamic>> records = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final result = await StorageService.getLeaderboard();

    if (!mounted) return;

    setState(() {
      records = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101517),
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: loading
          ? const Center(
        child: CircularProgressIndicator(color: lime),
      )
          : records.isEmpty
          ? const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              color: lime,
              size: 70,
            ),
            SizedBox(height: 15),
            Text(
              'Belum ada skor',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Selesaikan quiz untuk masuk leaderboard.',
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1B2425),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                  index < 3 ? lime : Colors.white12,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: index < 3
                          ? const Color(0xFF101517)
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        record['name']?.toString() ??
                            'Football Player',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        record['category']?.toString() ?? '-',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${record['score'] ?? 0} pts',
                  style: const TextStyle(
                    color: lime,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
