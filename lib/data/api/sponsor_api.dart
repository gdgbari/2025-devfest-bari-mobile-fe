import 'package:cloud_functions/cloud_functions.dart';
import 'package:devfest_bari_2024/data.dart';

class SponsorApi {
  Future<ServerResponse> getSponsorList() async {
    final result = await FirebaseFunctions.instance
        .httpsCallable('getSponsorList')
        .call<String>();

    return ServerResponse.fromJson(result.data);
  }
}
