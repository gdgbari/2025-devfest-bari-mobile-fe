import 'package:devfest_bari_2025/data.dart';

class ContestRulesRepository {
  final ContestRulesService _contestRulesService;

  const ContestRulesRepository(this._contestRulesService);

  Stream<ContestRules> contestRulesStream() async* {
    await for (final event in _contestRulesService.contestRulesStream) {
      String title = '';
      String content = '';
      bool showRules = true;

      for (final child in event.snapshot.children) {
        if (child.value == null) {
          continue;
        }
        switch (child.key) {
          case 'title':
            title = child.value as String;
            break;
          case 'content':
            content = child.value as String;
            break;
          case 'showRules':
            showRules = child.value as bool;
            break;
        }
      }

      yield ContestRules(
        title: title,
        content: content.replaceAll('\\n', '\n'),
        showRules: showRules,
      );
    }
  }
}
