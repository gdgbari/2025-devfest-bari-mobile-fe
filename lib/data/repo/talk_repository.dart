import 'dart:convert';

import 'package:devfest_bari_2024/data.dart';

class TalkRepository {
  TalkRepository._internal();

  static final TalkRepository _instance = TalkRepository._internal();

  factory TalkRepository() => _instance;

  final _talkApi = TalkApi();

  Future<List<Talk>> getTalkList() async {
    try {
      final String jsonTalkList = await _talkApi.getTalkList();
      final List<dynamic> rawTalkList = jsonDecode(jsonTalkList);
      return List<Talk>.from(
        rawTalkList.map(
          (rawTalk) => Talk.fromMap(rawTalk),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
