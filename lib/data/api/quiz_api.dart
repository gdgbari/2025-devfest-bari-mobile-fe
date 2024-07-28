import 'package:cloud_functions/cloud_functions.dart';

class QuizApi {
  Future<Map<String, dynamic>> fetchQuizList(String talkId) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('getTalkQuiz')
          .call<Map<String, dynamic>>({'talkId': talkId});

      return result.data;
    } on FirebaseFunctionsException catch (e) {
      return {};
    }
  }
}
