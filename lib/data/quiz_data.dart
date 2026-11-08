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
      options: [
        'Prancis',
        'Argentina',
        'Kroasia',
        'Brasil',
      ],
      correctAnswerIndex: 1,
      category: 'Piala Dunia',
      explanation:
      'Argentina mengalahkan Prancis melalui adu penalti di final.',
      difficulty: 'Mudah',
      points: 100,
    ),
    QuizQuestion(
      question: 'Siapa pencetak gol terbanyak sepanjang sejarah Piala Dunia pria hingga 2022?',
      options: [
        'Ronaldo Nazario',
        'Pelé',
        'Miroslav Klose',
        'Lionel Messi',
      ],
      correctAnswerIndex: 2,
      category: 'Piala Dunia',
      explanation:
      'Miroslav Klose mencetak 16 gol di Piala Dunia pria.',
      difficulty: 'Sedang',
      points: 150,
    ),
    QuizQuestion(
      question: 'Negara mana yang paling banyak menjuarai Piala Dunia pria hingga 2022?',
      options: [
        'Jerman',
        'Italia',
        'Argentina',
        'Brasil',
      ],
      correctAnswerIndex: 3,
      category: 'Piala Dunia',
      explanation:
      'Brasil telah menjuarai Piala Dunia pria sebanyak lima kali.',
      difficulty: 'Mudah',
      points: 100,
    ),
    QuizQuestion(
      question: 'Klub mana yang paling banyak menjuarai Liga Champions UEFA hingga musim 2023/24?',
      options: [
        'Barcelona',
        'Real Madrid',
        'AC Milan',
        'Liverpool',
      ],
      correctAnswerIndex: 1,
      category: 'Liga Champions',
      explanation:
      'Real Madrid meraih gelar Liga Champions Eropa ke-15 pada 2024.',
      difficulty: 'Mudah',
      points: 100,
    ),
    QuizQuestion(
      question: 'Pada tahun berapa Lionel Messi pertama kali memenangkan Ballon d’Or?',
      options: [
        '2007',
        '2008',
        '2009',
        '2010',
      ],
      correctAnswerIndex: 2,
      category: 'Pemain Legendaris',
      explanation:
      'Messi memenangkan Ballon d’Or pertamanya pada 2009.',
      difficulty: 'Sedang',
      points: 150,
    ),
    QuizQuestion(
      question: 'Siapa yang dikenal dengan julukan CR7?',
      options: [
        'Cristiano Ronaldo',
        'Ronaldo Nazario',
        'Ronaldinho',
        'Kaká',
      ],
      correctAnswerIndex: 0,
      category: 'Pemain Legendaris',
      explanation:
      'CR7 merujuk pada Cristiano Ronaldo dan nomor punggung ikoniknya.',
      difficulty: 'Mudah',
      points: 100,
    ),
    QuizQuestion(
      question: 'Berapa jumlah pemain satu tim yang berada di lapangan saat pertandingan dimulai?',
      options: [
        '9 pemain',
        '10 pemain',
        '11 pemain',
        '12 pemain',
      ],
      correctAnswerIndex: 2,
      category: 'Sepak Bola Umum',
      explanation:
      'Satu tim memainkan pertandingan dengan 11 pemain, termasuk penjaga gawang.',
      difficulty: 'Mudah',
      points: 100,
    ),
    QuizQuestion(
      question: 'Berapa lama waktu normal pertandingan sepak bola senior?',
      options: [
        '60 menit',
        '80 menit',
        '90 menit',
        '100 menit',
      ],
      correctAnswerIndex: 2,
      category: 'Sepak Bola Umum',
      explanation:
      'Waktu normal terdiri dari dua babak, masing-masing 45 menit, ditambah waktu tambahan.',
      difficulty: 'Mudah',
      points: 100,
    ),
    QuizQuestion(
      question: 'Negara mana yang menjadi tuan rumah Piala Dunia 2018?',
      options: [
        'Qatar',
        'Rusia',
        'Jerman',
        'Afrika Selatan',
      ],
      correctAnswerIndex: 1,
      category: 'Piala Dunia',
      explanation:
      'Piala Dunia 2018 diselenggarakan di Rusia.',
      difficulty: 'Mudah',
      points: 100,
    ),
    QuizQuestion(
      question: 'Klub mana yang dibela Lionel Messi saat menjuarai Piala Dunia 2022?',
      options: [
        'Barcelona',
        'Paris Saint-Germain',
        'Inter Miami',
        'Manchester City',
      ],
      correctAnswerIndex: 1,
      category: 'Pemain Legendaris',
      explanation:
      'Saat Piala Dunia 2022 berlangsung, Messi bermain untuk Paris Saint-Germain.',
      difficulty: 'Sulit',
      points: 200,
    ),
    QuizQuestion(
      question: 'Apa nama penghargaan untuk kiper terbaik di Piala Dunia FIFA?',
      options: [
        'Golden Boot',
        'Golden Glove',
        'Golden Ball',
        'Puskás Award',
      ],
      correctAnswerIndex: 1,
      category: 'Piala Dunia',
      explanation:
      'Golden Glove diberikan kepada penjaga gawang terbaik turnamen.',
      difficulty: 'Sedang',
      points: 150,
    ),
    QuizQuestion(
      question: 'Negara mana yang menjuarai Euro 2024?',
      options: [
        'Inggris',
        'Prancis',
        'Spanyol',
        'Portugal',
      ],
      correctAnswerIndex: 2,
      category: 'Sepak Bola Umum',
      explanation:
      'Spanyol mengalahkan Inggris 2-1 di final Euro 2024.',
      difficulty: 'Sedang',
      points: 150,
    ),
  ];
}
