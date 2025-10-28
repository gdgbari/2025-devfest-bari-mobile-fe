import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/utils.dart';
import 'package:dio/dio.dart';

class QuizServiceImpl implements QuizService {
  QuizServiceImpl();

  final Dio _dio = HttpClient().dio;
  final String _endpoint = '/quiz';

  @override
  Future<Response> getQuiz(String quizCode) async {
    try {
      return await _dio.get('$_endpoint/$quizCode');
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 400:
          throw QuizInvalidCode();
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

  @override
  Future<Response> submitQuiz(String quizId, List<String?> answerList) async {
    try {
      return await _dio.post(
        '$_endpoint/submit',
        data: {'quiz_id': quizId, 'answer_list': answerList},
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
