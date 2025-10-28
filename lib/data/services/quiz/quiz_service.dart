import 'package:dio/dio.dart';

abstract class QuizService {
  Future<Response> getQuiz(String quizCode);
  Future<Response> submitQuiz(String quizId, List<String?> answerList);
}
