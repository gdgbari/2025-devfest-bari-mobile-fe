import 'package:devfest_bari_2025/data.dart';

class QuizRepository {
  final QuizService _quizService;

  const QuizRepository(this._quizService);

  Future<Quiz> getQuiz(String quizCode) async {
    final response = await _quizService.getQuiz(quizCode);
    return Quiz.fromJson(response.data);
  }

  Future<QuizResults> submitQuiz(
    String quizId,
    List<String?> answerList,
  ) async {
    final response = await _quizService.submitQuiz(quizId, answerList);
    return QuizResults.fromJson(response.data);
  }
}
