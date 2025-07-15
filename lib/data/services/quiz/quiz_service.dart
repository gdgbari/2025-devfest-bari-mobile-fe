import 'package:devfest_bari_2025/data.dart';

abstract class QuizService {
  Future<ServerResponse> getQuiz(String quizCode);
  Future<ServerResponse> submitQuiz(
    String quizId,
    List<String?> answerList,
  );
}
