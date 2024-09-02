import 'dart:convert';

import 'package:devfest_bari_2024/data.dart';

class SponsorRepository {
  SponsorRepository._internal();

  static final SponsorRepository _instance = SponsorRepository._internal();

  factory SponsorRepository() => _instance;

  final _sponsorApi = SponsorApi();

  Future<List<Talk>> getSponsorList() async {
    try {
      final response = await _sponsorApi.getSponsorList();

      if (response.error.code.isNotEmpty) {
        // TODO: handle errors
        throw UnknownSponsorError();
      }

      final List<dynamic> rawTalkList = jsonDecode(response.data);

      return List<Talk>.from(
        rawTalkList.map((rawTalk) => Talk.fromMap(rawTalk)),
      );
    } on Exception {
      throw UnknownTalkError();
    }
  }
}
