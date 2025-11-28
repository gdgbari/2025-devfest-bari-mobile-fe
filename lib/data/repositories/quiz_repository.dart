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
    List<QuizAnswer> selectedAnswers,
  ) async {
    // Convert List<QuizAnswer> to Map<String, String?> for the service
    final answersMap = {
      for (var answer in selectedAnswers) answer.questionId: answer.answerId,
    };

    final response = await _quizService.submitQuiz(quizId, answersMap);
    return QuizResults.fromJson(response.data);
  }
}
