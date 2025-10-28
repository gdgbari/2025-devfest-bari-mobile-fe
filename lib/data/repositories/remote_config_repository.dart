import 'package:devfest_bari_2025/data.dart';

class RemoteConfigRepository {
  final RemoteConfigService _configService;

  RemoteConfigRepository(this._configService);

  Stream<RemoteConfig> get config {
    return _configService.config.map((event) => RemoteConfig.fromJson(event));
  }
}
