import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _onboardingShown =
          prefs.getBool('ff_onboardingShown') ?? _onboardingShown;
    });
    _safeInit(() {
      _keyIos = prefs.getString('ff_keyIos') ?? _keyIos;
    });
    _safeInit(() {
      _keyAndroid = prefs.getString('ff_keyAndroid') ?? _keyAndroid;
    });
    _safeInit(() {
      _keyWeb = prefs.getString('ff_keyWeb') ?? _keyWeb;
    });
    _safeInit(() {
      _teamColors = prefs
              .getStringList('ff_teamColors')
              ?.map((x) => Color(int.tryParse(x) ?? 0))
              .toList() ??
          _teamColors;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _onboardingShown = false;
  bool get onboardingShown => _onboardingShown;
  set onboardingShown(bool value) {
    _onboardingShown = value;
    prefs.setBool('ff_onboardingShown', value);
  }

  String _keyIos = 'AIzaSyDgS1uwaDSxgiHoHe04eI1Uq6xABin-Ais';
  String get keyIos => _keyIos;
  set keyIos(String value) {
    _keyIos = value;
    prefs.setString('ff_keyIos', value);
  }

  String _keyAndroid = 'AIzaSyC2wPxki-HJVaAghjxZnL-0zzOb8M1O_qI';
  String get keyAndroid => _keyAndroid;
  set keyAndroid(String value) {
    _keyAndroid = value;
    prefs.setString('ff_keyAndroid', value);
  }

  String _keyWeb = 'AIzaSyCzuU9a2LQLYxJgyo3W7tcPjrianeeBL7I';
  String get keyWeb => _keyWeb;
  set keyWeb(String value) {
    _keyWeb = value;
    prefs.setString('ff_keyWeb', value);
  }

  int _navbarIndex = 0;
  int get navbarIndex => _navbarIndex;
  set navbarIndex(int value) {
    _navbarIndex = value;
  }

  List<Color> _teamColors = [
    Color(4294919482),
    Color(4281451605),
    Color(4294892596),
    Color(4288570089),
    Color(4284672481),
    Color(4294967295)
  ];
  List<Color> get teamColors => _teamColors;
  set teamColors(List<Color> value) {
    _teamColors = value;
    prefs.setStringList(
        'ff_teamColors', value.map((x) => x.value.toString()).toList());
  }

  void addToTeamColors(Color value) {
    teamColors.add(value);
    prefs.setStringList(
        'ff_teamColors', _teamColors.map((x) => x.value.toString()).toList());
  }

  void removeFromTeamColors(Color value) {
    teamColors.remove(value);
    prefs.setStringList(
        'ff_teamColors', _teamColors.map((x) => x.value.toString()).toList());
  }

  void removeAtIndexFromTeamColors(int index) {
    teamColors.removeAt(index);
    prefs.setStringList(
        'ff_teamColors', _teamColors.map((x) => x.value.toString()).toList());
  }

  void updateTeamColorsAtIndex(
    int index,
    Color Function(Color) updateFn,
  ) {
    teamColors[index] = updateFn(_teamColors[index]);
    prefs.setStringList(
        'ff_teamColors', _teamColors.map((x) => x.value.toString()).toList());
  }

  void insertAtIndexInTeamColors(int index, Color value) {
    teamColors.insert(index, value);
    prefs.setStringList(
        'ff_teamColors', _teamColors.map((x) => x.value.toString()).toList());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

Color? _colorFromIntValue(int? val) {
  if (val == null) {
    return null;
  }
  return Color(val);
}
