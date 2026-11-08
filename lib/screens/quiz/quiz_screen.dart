
import 'package:flutter/material.dart';

import '../../data/quiz_data.dart';
import '../../models/quiz_question.dart';
import '../../services/storage_service.dart';
import '../../widgets/primary_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String category;
  final String playerName;

  const QuizScreen({
    super.key,
    required this.category,
    required this.playerName,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const lime = Color(0xFFB7F34A);

  late List<QuizQuestion> _questions;
  late List<int> _answers;

  int _currentIndex = 0;
  int _score = 0;
  int _correct = 0;
  int? _selectedAnswer;

  bool _isLoading = true;
  bool _isFinishing = false;

  @override
  void initState() {
    super.initState();

    _questions = QuizData.getQuestions(widget.category);
    _answers = List<int>.filled(_questions.length, -1);

    _restoreProgress();
  }

  Future<void> _restoreProgress() async {
    if (_questions.isEmpty) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      return;
    }

    final saved = await StorageService.getQuizProgress();

    if (!mounted) return;

    if (saved != null && saved['category'] == widget.category) {
      final savedIndex = saved['index'] as int? ?? 0;

      final savedAnswers =
      (saved['answers'] as List<dynamic>? ?? [])
          .map((value) => value as int)
          .toList();

      final safeIndex = savedIndex.clamp(0, _questions.length - 1);

      setState(() {
        _currentIndex = safeIndex;
        _score = saved['score'] as int? ?? 0;
        _correct = saved['correct'] as int? ?? 0;

        for (int i = 0;
        i < savedAnswers.length && i < _answers.length;
        i++) {
          _answers[i] = savedAnswers[i];
        }

        final answer = _answers[_currentIndex];

        _selectedAnswer = answer == -1 ? null : answer;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  QuizQuestion get _currentQuestion =>
      _questions[_currentIndex];

  Future<void> _saveProgress() async {
    await StorageService.saveQuizProgress(
      category: widget.category,
      index: _currentIndex,
      score: _score,
      correct: _correct,
      total: _questions.length,
      answers: List<int>.from(_answers),
    );
  }

  Future<void> _selectAnswer(int index) async {
    if (_selectedAnswer != null || _isFinishing) return;

    setState(() {
      _selectedAnswer = index;
      _answers[_currentIndex] = index;

      if (index == _currentQuestion.correctAnswerIndex) {
        _score += _currentQuestion.points;
        _correct++;
      }
    });

    await _saveProgress();
  }

  Future<void> _nextQuestion() async {
    if (_selectedAnswer == null || _isFinishing) return;

    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = _answers[_currentIndex] == -1
            ? null
            : _answers[_currentIndex];
      });

      await _saveProgress();
    } else {
      await _finishQuiz();
    }
  }

  Future<void> _finishQuiz() async {
    if (_isFinishing) return;

    setState(() {
      _isFinishing = true;
    });

    await StorageService.saveLeaderboard(
      name: widget.playerName,
      category: widget.category,
      score: _score,
      correct: _correct,
      total: _questions.length,
    );

    await StorageService.clearQuizProgress();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          playerName: widget.playerName,
          category: widget.category,
          score: _score,
          correct: _correct,
          total: _questions.length,
        ),
      ),
    );
  }

  Color _optionColor(int index) {
    if (_selectedAnswer == null) {
      return const Color(0xFF1B2425);
    }

    if (index == _currentQuestion.correctAnswerIndex) {
      return const Color(0xFF263A22);
    }

    if (index == _selectedAnswer) {
      return const Color(0xFF49272A);
    }

    return const Color(0xFF1B2425);
  }

  Widget _buildOption(int index) {
    final isSelected = _selectedAnswer == index;
    final isCorrect =
        index == _currentQuestion.correctAnswerIndex;

    IconData? trailingIcon;

    if (_selectedAnswer != null && isCorrect) {
      trailingIcon = Icons.check_circle;
    } else if (isSelected && !isCorrect) {
      trailingIcon = Icons.cancel;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _selectAnswer(index),
        borderRadius: BorderRadius.circular(15),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _optionColor(index),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: _selectedAnswer != null && isCorrect
                  ? lime
                  : isSelected
                  ? Colors.redAccent
                  : Colors.white12,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(
                  String.fromCharCode(65 + index),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Text(
                  _currentQuestion.options[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (trailingIcon != null)
                Icon(
                  trailingIcon,
                  color: isCorrect ? lime : Colors.redAccent,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF101517),
        body: Center(
          child: CircularProgressIndicator(color: lime),
        ),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF101517),
        appBar: AppBar(
          backgroundColor: const Color(0xFF101517),
          title: const Text('Football Quiz'),
        ),
        body: const Center(
          child: Text(
            'Tidak ada pertanyaan untuk kategori ini.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final progress = (_currentIndex + 1) / _questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFF101517),
      appBar: AppBar(
        backgroundColor: const Color(0xFF101517),
        title: const Text(
          'Football Quiz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 650),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.category,
                            style: const TextStyle(
                              color: lime,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_currentIndex + 1}/${_questions.length}',
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 8,
                          backgroundColor: Colors.white12,
                          valueColor:
                          const AlwaysStoppedAnimation(lime),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          const Icon(Icons.stars, color: lime),
                          const SizedBox(width: 7),
                          Text(
                            '$_score Poin',
                            style: const TextStyle(
                              color: lime,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _currentQuestion.difficulty,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'PERTANYAAN',
                        style: TextStyle(
                          color: Colors.white54,
                          letterSpacing: 1.5,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 13),
                      Text(
                        _currentQuestion.question,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          height: 1.4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 27),
                      ...List.generate(
                        _currentQuestion.options.length,
                        _buildOption,
                      ),
                      if (_selectedAnswer != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B2425),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedAnswer ==
                                    _currentQuestion.correctAnswerIndex
                                    ? 'Jawaban Benar!'
                                    : 'Belum Tepat!',
                                style: const TextStyle(
                                  color: lime,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                _currentQuestion.explanation,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  height: 1.5,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          text: _currentIndex == _questions.length - 1
                              ? 'LIHAT HASIL'
                              : 'PERTANYAAN SELANJUTNYA',
                          onPressed: _nextQuestion,
                          icon: Icons.arrow_forward,
                          isLoading: _isFinishing,
                        ),
                      ],
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
