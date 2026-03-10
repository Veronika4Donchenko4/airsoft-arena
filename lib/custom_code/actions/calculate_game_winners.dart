// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import "package:collection/collection.dart";

Future<List<DocumentReference>> calculateGameWinners(
    List<GameRoundRecord> gameRoundList) async {
  // 1. Группируем записи по teamWinner (предполагаем, что teamWinner - это DocumentReference)
  Map<DocumentReference, List<GameRoundRecord>> grouped = groupBy(
    gameRoundList.where((record) => record.teamWinner != null).toList(),
    (record) => record.teamWinner!,
  );

  for (var i in grouped.entries.toList()) {
    print("qwe__________________${i.value.length}");
  }

  // 2. Сортируем группы по убыванию количества элементов (побед)
  var sortedEntries = grouped.entries.toList()
    ..sort((a, b) => b.value.length.compareTo(a.value.length));

  // 3. Находим максимальное количество побед
  if (sortedEntries.isEmpty) return [];
  int maxWins = sortedEntries.first.value.length;

  // 4. Отбираем все команды с максимальным количеством побед
  List<DocumentReference> teamWinners = sortedEntries
      // .where((entry) => entry.value.length == maxWins)
      .map((entry) => entry.key)
      .toList();

  // return teamWinners;
  return [teamWinners[0]];
}
