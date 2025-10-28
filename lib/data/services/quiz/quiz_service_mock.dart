import 'package:devfest_bari_2025/data.dart';
import 'package:dio/dio.dart';

class QuizServiceMock implements QuizService {
  QuizServiceMock();
  
  @override
  Future<Response> getQuiz(String quizCode) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    return Response(
      requestOptions: RequestOptions(),
      data: {
        'quizId': 'quiz_$quizCode',
        'title': 'DevFest Bari 2025 Quiz',
        'type': 'talk',
        'timerDuration': 180000,
        'maxScore': 30,
        'questionList': [
          {
            'questionId': 'q1',
            'text': 'What is Flutter?',
            'answerList': [
              {'id': 'a1', 'text': 'A mobile app development framework'},
              {'id': 'a2', 'text': 'A web development framework'},
              {'id': 'a3', 'text': 'A database management system'},
              {'id': 'a4', 'text': 'A cloud computing platform'},
            ],
            'value': 10,
          },
          {
            'questionId': 'q2',
            'text': 'Which programming language is primarily used in Flutter?',
            'answerList': [
              {'id': 'a5', 'text': 'Dart'},
              {'id': 'a6', 'text': 'JavaScript'},
              {'id': 'a7', 'text': 'Python'},
              {'id': 'a8', 'text': 'Java'},
            ],
            'value': 10,
          },
          {
            'questionId': 'q3',
            'text': 'What is the main advantage of Flutter?',
            'answerList': [
              {'id': 'a9', 'text': 'Cross-platform development'},
              {'id': 'a10', 'text': 'Better performance than native apps'},
              {'id': 'a11', 'text': 'Hot reload feature'},
              {'id': 'a12', 'text': 'All of the above'},
            ],
            'value': 10,
          },
        ],
      },
    );
  }

  @override
  Future<Response> submitQuiz(String quizId, List<String?> answerList) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    return Response(
      requestOptions: RequestOptions(),
      data: {'score': 20, 'maxScore': 30},
    );
  }
}
