import 'package:cloud_functions/cloud_functions.dart';

class TalkApi {
  Future<String> getTalkList() async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('getTalkList')
          .call<String>();

      return result.data;
    } on FirebaseFunctionsException {
      rethrow;
    }
  }
}
