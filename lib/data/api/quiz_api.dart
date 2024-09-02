import 'package:cloud_functions/cloud_functions.dart';
import 'package:devfest_bari_2024/data.dart';

class QuizApi {
  Future<ServerResponse> getQuiz(String quizId) async {
    final body = {'quizId': quizId};

    final result = await FirebaseFunctions.instance
        .httpsCallable('getQuiz')
        .call<String>(body);

    return ServerResponse.fromJson(result.data);
  }

  Future<ServerResponse> submitQuiz(
    String quizId,
    List<int?> answerList,
  ) async {
    final body = {
      'quizId': quizId,
      'answerList': answerList,
    };

    final result = await FirebaseFunctions.instance
        .httpsCallable('submitQuiz')
        .call<String>(body);

    return ServerResponse.fromJson(result.data);
  }
}
