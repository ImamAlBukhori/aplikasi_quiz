
import '../models/quiz_question.dart';

class QuizData {
  static const List<String> categories = [
    'Semua Kategori',
    'Piala Dunia',
    'Liga Champions',
    'Pemain Legendaris',
    'Sepak Bola Umum',
  ];

  static const List<QuizQuestion> questions = [
    QuizQuestion(
      question: 'Negara mana yang menjuarai Piala Dunia 2022?',
      options: ['Brazil', 'Argentina', 'Prancis', 'Jerman'],
      correctAnswerIndex: 1,
      category: 'Piala Dunia',
      explanation: 'Argentina mengalahkan Prancis melalui adu penalti pada final Piala Dunia 2022.',
      difficulty: 'Mudah',
    ),
    QuizQuestion(
      question: 'Siapa pencetak gol terbanyak sepanjang sejarah Piala Dunia?',
      options: ['Ronaldo Nazario', 'Lionel Messi', 'Miroslav Klose', 'Pelé'],
      correctAnswerIndex: 2,
      category: 'Piala Dunia',
      explanation: 'Miroslav Klose mencetak 16 gol dalam empat edisi Piala Dunia.',
      difficulty: 'Sedang',
    ),
    QuizQuestion(
      question: 'Negara mana yang paling banyak menjuarai Piala Dunia?',
      options: ['Jerman', 'Italia', 'Argentina', 'Brazil'],
      correctAnswerIndex: 3,
      category: 'Piala Dunia',
      explanation: 'Brazil telah menjuarai Piala Dunia sebanyak lima kali.',
      difficulty: 'Mudah',
    ),
    QuizQuestion(
      question: 'Klub mana yang menjuarai Liga Champions musim 2023/2024?',
      options: ['Manchester City', 'Real Madrid', 'Bayern Munchen', 'Dortmund'],
      correctAnswerIndex: 1,
      category: 'Liga Champions',
      explanation: 'Real Madrid mengalahkan Borussia Dortmund 2-0 di final 2024.',
      difficulty: 'Mudah',
    ),
    QuizQuestion(
      question: 'Klub mana yang memiliki gelar Liga Champions terbanyak?',
      options: ['Barcelona', 'AC Milan', 'Real Madrid', 'Liverpool'],
      correctAnswerIndex: 2,
      category: 'Liga Champions',
      explanation: 'Real Madrid merupakan klub dengan gelar European Cup/Liga Champions terbanyak.',
      difficulty: 'Mudah',
    ),
    QuizQuestion(
      question: 'Siapa pemain yang mencetak gol kemenangan Real Madrid pada final UCL 2022?',
      options: ['Karim Benzema', 'Vinicius Junior', 'Luka Modric', 'Rodrygo'],
      correctAnswerIndex: 1,
      category: 'Liga Champions',
      explanation: 'Vinicius Junior mencetak satu-satunya gol saat melawan Liverpool.',
      difficulty: 'Sedang',
    ),
    QuizQuestion(
      question: 'Siapa pemain yang dijuluki CR7?',
      options: ['Cristiano Ronaldo', 'Ronaldo Nazario', 'Ronaldinho', 'Rivaldo'],
      correctAnswerIndex: 0,
      category: 'Pemain Legendaris',
      explanation: 'CR7 adalah julukan yang identik dengan Cristiano Ronaldo.',
      difficulty: 'Mudah',
    ),
    QuizQuestion(
      question: 'Siapa pemain yang memenangkan Ballon d’Or pertama pada tahun 2009?',
      options: ['Kaka', 'Cristiano Ronaldo', 'Lionel Messi', 'Xavi'],
      correctAnswerIndex: 2,
      category: 'Pemain Legendaris',
      explanation: 'Lionel Messi memenangkan Ballon d’Or pertamanya pada tahun 2009.',
      difficulty: 'Sedang',
    ),
    QuizQuestion(
      question: 'Zinedine Zidane memenangkan Piala Dunia bersama negara mana?',
      options: ['Italia', 'Prancis', 'Spanyol', 'Portugal'],
      correctAnswerIndex: 1,
      category: 'Pemain Legendaris',
      explanation: 'Zidane membawa Prancis menjadi juara Piala Dunia 1998.',
      difficulty: 'Mudah',
    ),
    QuizQuestion(
      question: 'Berapa jumlah pemain dari satu tim yang berada di lapangan saat pertandingan normal?',
      options: ['9', '10', '11', '12'],
      correctAnswerIndex: 2,
      category: 'Sepak Bola Umum',
      explanation: 'Setiap tim memainkan pertandingan dengan maksimal 11 pemain di lapangan.',
      difficulty: 'Mudah',
    ),
    QuizQuestion(
      question: 'Berapa lama waktu normal pertandingan sepak bola?',
      options: ['60 menit', '70 menit', '80 menit', '90 menit'],
      correctAnswerIndex: 3,
      category: 'Sepak Bola Umum',
      explanation: 'Pertandingan normal berlangsung selama dua babak, masing-masing 45 menit.',
      difficulty: 'Mudah',
    ),
    QuizQuestion(
      question: 'Negara mana yang menjadi juara Euro 2024?',
      options: ['Inggris', 'Prancis', 'Spanyol', 'Jerman'],
      correctAnswerIndex: 2,
      category: 'Sepak Bola Umum',
      explanation: 'Spanyol mengalahkan Inggris 2-1 pada final Euro 2024.',
      difficulty: 'Sedang',
    ),
  ];

  static List<QuizQuestion> getQuestions(String category) {
    if (category == 'Semua Kategori') {
      return questions;
    }

    return questions
        .where((question) => question.category == category)
        .toList();
  }
}
