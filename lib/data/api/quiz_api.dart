import 'package:cloud_functions/cloud_functions.dart';

class QuizApi {
  Future<String> getQuiz(String quizId) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('getQuiz')
          .call<String>({'quizId': quizId});

      return result.data;
    } on FirebaseFunctionsException {
      rethrow;
    }
  }

  Future<String> submitQuiz(String quizId, List<int?> answerList) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('submitQuiz')
          .call<String>(
        {
          'quizId': quizId,
          'answerList': answerList,
        },
      );

      return result.data;
    } catch (e) {
      rethrow;
    }
  }
}
