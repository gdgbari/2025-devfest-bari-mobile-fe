import 'package:devfest_bari_2025/data.dart';

class EasterEggRepository {
  final EasterEggService _easterEggService;

  const EasterEggRepository(this._easterEggService);

  Stream<String> easterEggStream() async* {
    await for (final event in _easterEggService.easterEggStream) {
      final easterEggMessage = event.snapshot.value as String? ?? '';
      yield easterEggMessage.replaceAll('\\n', '\n');
    }
  }
}
