import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/utils.dart';
import 'package:dio/dio.dart';

class QuizServiceImpl implements QuizService {
  QuizServiceImpl({Dio? dio}) : _dio = dio ?? HttpClient().dio;

  final Dio _dio;
  final String _endpoint = '/quizzes';

  @override
  Future<Response> getQuiz(String quizCode) async {
    try {
      return await _dio.get('$_endpoint/$quizCode');
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 403:
          final detail = e.response?.data['detail'];
          if (detail != null) {
            throw QuizForbiddenError(detail.toString());
          }
          throw QuizNotOpenError();
        case 404:
          throw QuizNotFoundError();
        case 408:
          throw QuizTimeIsUpError();
        case 409:
          throw QuizAlreadySubmittedError();
        default:
          throw UnknownQuizError();
      }
    }
  }

  @override
  Future<Response> submitQuiz(
    String quizId,
    Map<String, String?> selectedAnswers,
  ) async {
    try {
      // Build the answers array with question_id and answer_id pairs
      final answers = selectedAnswers.entries
          .where((entry) => entry.value != null)
          .map((entry) => {'question_id': entry.key, 'answer_id': entry.value})
          .toList();

      return await _dio.post(
        '$_endpoint/$quizId/submit',
        data: {'answers': answers},
      );
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 404:
          throw QuizNotFoundError();
        case 409:
          throw QuizAlreadySubmittedError();
        case 408:
          throw QuizTimeIsUpError();
        case 423:
          throw QuizNotOpenError();
        default:
          throw UnknownQuizError();
      }
    }
  }
}
