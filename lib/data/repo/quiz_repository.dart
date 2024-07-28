import 'package:devfest_bari_2024/data.dart';

class QuizRepository {
  QuizRepository._internal();

  static final QuizRepository _instance = QuizRepository._internal();

  factory QuizRepository() => _instance;

  final QuizApi _quizApi = QuizApi();

  Future<List<Quiz>> fetchQuizList() async {
    // TODO: fetch actual data from firestore
    final quizList = <Quiz>[
      const Quiz(
        quizId: 'quiz1',
        question: 'In che anno Cristoforo Colombro scoprì l\'America?',
        answerList: <String>['1182', '1282', '1382', '1482'],
      ),
      const Quiz(
        quizId: 'quiz2',
        question: 'Chi è l\'attuale presidente degli USA?',
        answerList: <String>[
          'Joe Biden',
          'Barack Obama',
          'Donald Trump',
          'George Washington'
        ],
      ),
    ];
    return quizList;
  }
}
