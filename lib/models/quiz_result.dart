class QuizResult {
  final String playerName;
  final String character;
  final String category;
  final int score;
  final int correctAnswers;
  final int totalQuestions;
  final int timeTakenInSeconds;
  final DateTime completedAt;

  const QuizResult({
    required this.playerName,
    required this.character,
    required this.category,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.timeTakenInSeconds,
    required this.completedAt,
  });

  double get accuracy {
    if (totalQuestions == 0) return 0;
    return correctAnswers / totalQuestions * 100;
  }

  String get formattedTime {
    final minutes = timeTakenInSeconds ~/ 60;
    final seconds = timeTakenInSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
}
