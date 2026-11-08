
class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String category;
  final String explanation;
  final String difficulty;
  final int points;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.category,
    required this.explanation,
    required this.difficulty,
    this.points = 100,
  });
}
