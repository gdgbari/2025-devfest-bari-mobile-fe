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
        answerList: <Answer>[
          Answer(
            ansId: 'q1a1',
            text: '1182',
          ),
          Answer(
            ansId: 'q1a2',
            text: '1282',
          ),
          Answer(
            ansId: 'q1a3',
            text: '1382',
          ),
          Answer(
            ansId: 'q1a4',
            text: '1482',
          ),
        ],
      ),
      const Quiz(
        quizId: 'quiz2',
        question: 'Chi è l\'attuale presidente degli USA?',
        answerList: <Answer>[
          Answer(
            ansId: 'q2a1',
            text: 'Joe Biden',
          ),
          Answer(
            ansId: 'q2a2',
            text: 'Barack Obama',
          ),
          Answer(
            ansId: 'q2a3',
            text: 'Donald Trump',
          ),
          Answer(
            ansId: 'q2a4',
            text: 'George Washington',
          ),
        ],
      ),
    ];
    return quizList;
  }
}
