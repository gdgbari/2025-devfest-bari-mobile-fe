import 'package:devfest_bari_2025/data.dart';

final mockUsers = <String, dynamic>{
  'uid1': {
    'nickname': 'test01',
    'group_color': 'red',
    'score': 30,
    'timestamp': 1729935104457,
    'position': 1,
  },
  'uid2': {
    'nickname': 'test02',
    'group_color': 'blue',
    'score': 20,
    'timestamp': 1729935104456,
    'position': 2,
  },
  'uid3': {
    'nickname': 'test03',
    'group_color': 'yellow',
    'score': 10,
    'timestamp': 1729935104455,
    'position': 3,
  },
  'uid4': {
    'nickname': 'test04',
    'group_color': 'green',
    'score': 0,
    'timestamp': 1729935104454,
    'position': 4,
  },
};
final mockGroups = <String, dynamic>{
  'gid1': {
    'name': 'focaccia',
    'color': 'red',
    'score': 30,
    'timestamp': 1729935104457,
    'position': 1,
  },
  'gid2': {
    'name': 'polpo',
    'color': 'blue',
    'score': 20,
    'timestamp': 1729935104456,
    'position': 2,
  },
  'gid3': {
    'name': 'panzerotto',
    'color': 'yellow',
    'score': 10,
    'timestamp': 1729935104455,
    'position': 3,
  },
  'gid4': {
    'name': 'orecchiette',
    'color': 'green',
    'score': 0,
    'timestamp': 1729935104454,
    'position': 4,
  },
};

class LeaderboardServiceMock implements LeaderboardService {
  @override
  Stream<Map<String, dynamic>> get userLeaderboardStream async* {
    yield mockUsers;
  }

  @override
  Stream<Map<String, dynamic>> get groupLeaderboardStream async* {
    yield mockGroups;
  }
}
