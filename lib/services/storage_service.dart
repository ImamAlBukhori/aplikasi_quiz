
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<SharedPreferences> get _prefs async {
    return SharedPreferences.getInstance();
  }

  // DATA PROFILE
  static Future<void> saveProfile({
    required String name,
    required String education,
    required String nim,
  }) async {
    final prefs = await _prefs;

    await prefs.setString('user_name', name);
    await prefs.setString('user_education', education);

    if (education == 'Kuliah') {
      await prefs.setString('user_nim', nim);
    } else {
      await prefs.remove('user_nim');
    }
  }

  // SIMPAN PROGRES QUIZ
  static Future<void> saveQuizProgress({
    required String category,
    required int index,
    required int score,
    required int correct,
    required int total,
    required List<int> answers,
  }) async {
    final prefs = await _prefs;

    final progress = {
      'category': category,
      'index': index,
      'score': score,
      'correct': correct,
      'total': total,
      'answers': answers,
    };

    await prefs.setString('quiz_progress', jsonEncode(progress));
  }

  static Future<Map<String, dynamic>?> getQuizProgress() async {
    final prefs = await _prefs;
    final data = prefs.getString('quiz_progress');

    if (data == null) return null;

    try {
      return jsonDecode(data) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  static Future<void> clearQuizProgress() async {
    final prefs = await _prefs;
    await prefs.remove('quiz_progress');
  }

  // LEADERBOARD
  static Future<void> saveLeaderboard({
    required String name,
    required String category,
    required int score,
    required int correct,
    required int total,
  }) async {
    final prefs = await _prefs;
    final oldData = prefs.getString('leaderboard');

    List<dynamic> records = [];

    if (oldData != null) {
      try {
        records = jsonDecode(oldData) as List<dynamic>;
      } catch (_) {
        records = [];
      }
    }

    records.add({
      'name': name,
      'category': category,
      'score': score,
      'correct': correct,
      'total': total,
      'date': DateTime.now().toIso8601String(),
    });

    records.sort(
          (a, b) => (b['score'] as int).compareTo(a['score'] as int),
    );

    if (records.length > 20) {
      records = records.take(20).toList();
    }

    await prefs.setString('leaderboard', jsonEncode(records));
  }

  static Future<List<Map<String, dynamic>>> getLeaderboard() async {
    final prefs = await _prefs;
    final data = prefs.getString('leaderboard');

    if (data == null) return [];

    try {
      final decoded = jsonDecode(data) as List;
      return decoded
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    } catch (_) {
      return [];
    }
  }
}
