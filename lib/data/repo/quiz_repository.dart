import 'package:devfest_bari_2024/data.dart';

class QuizRepository {
  QuizRepository._internal();

  static final QuizRepository _instance = QuizRepository._internal();

  factory QuizRepository() => _instance;

  final QuizApi _quizApi = QuizApi();

  Future<Quiz> getQuiz(String quizId) async {
    try {
      final response = await _quizApi.getQuiz(quizId);

      if (response.error.code.isNotEmpty) {
        // TODO: handle errors
        throw UnknownQuizError();
      }

      return Quiz.fromJson(response.data);
    } on Exception {
      throw UnknownQuizError();
    }
  }

  Future<QuizResults> submitQuiz(String quizId, List<String?> answerList) async {
    try {
      final response = await _quizApi.submitQuiz(quizId, answerList);

      if (response.error.code.isNotEmpty) {
        // TODO: handle errors
        throw UnknownQuizError();
      }

      return QuizResults.fromJson(response.data);
    } on Exception {
      throw UnknownQuizError();
    }
  }
}
