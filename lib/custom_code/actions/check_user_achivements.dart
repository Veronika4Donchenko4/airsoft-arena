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

Future checkUserAchivements(
    DocumentReference user, List<AchievementRecord> achievements) async {
  final userLoaded = await UserRecord.getDocumentOnce(user);
  if (userLoaded == null) return;

  // Загрузка всех уже полученных достижений
  final existingUserAchievements = await queryUserAchievementsRecordOnce(
    queryBuilder: (userAchievementsRecord) => userAchievementsRecord.where(
      'user',
      isEqualTo: user,
    ),
  );

  final existingAchievementIds = existingUserAchievements
      .map((record) => record.achievement?.id)
      .whereType<String>()
      .toSet();

  // Подсчёт побед подряд и общего числа побед
  int currentWinSeries = 0;
  int maxWinSeries = 0;
  int winsCount = 0;

  for (final win in userLoaded.seriesNoLosess ?? []) {
    if (win) {
      currentWinSeries++;
      winsCount++;
      maxWinSeries = max(maxWinSeries, currentWinSeries);
    } else {
      currentWinSeries = 0;
    }
  }

  for (final achievement in achievements) {
    if (existingAchievementIds.contains(achievement.reference.id)) {
      continue; // достижение уже есть
    }

    final condMaxKills = achievement.maxKills;
    final condGameCount = achievement.gameCount;
    final condWinSeries = achievement.winSeries;
    final condWinsCount = achievement.winsCount;
    final condRate = achievement.rate;

    bool conditionMet = false;

    if (condMaxKills != null &&
        condMaxKills > 0 &&
        userLoaded.maxKills >= condMaxKills) {
      conditionMet = true;
    } else if (condGameCount != null &&
        condGameCount > 0 &&
        userLoaded.gameCount >= condGameCount) {
      conditionMet = true;
    } else if (condWinSeries != null &&
        condWinSeries > 0 &&
        maxWinSeries >= condWinSeries) {
      conditionMet = true;
    } else if (condWinsCount != null &&
        condWinsCount > 0 &&
        winsCount >= condWinsCount) {
      conditionMet = true;
    } else if (condRate != null &&
        condRate > 0 &&
        userLoaded.rate >= condRate) {
      conditionMet = true;
    }

    if (conditionMet) {
      await UserAchievementsRecord.collection
          .doc()
          .set(createUserAchievementsRecordData(
            user: user,
            achievement: achievement.reference,
          ));
    }
  }
}
