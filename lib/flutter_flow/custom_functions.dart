import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

List<int> getIndicatorsList(int count) {
  List<int> list = [];
  for (var i = 0; i < count; i++) {
    list.add(i);
  }
  return list;
}

bool joinToGame(
  List<DocumentReference> usersInGame,
  int maxTeam,
  int maxPlayers,
  List<TeamRecord> teams,
) {
  // bool join = usersInGame.length < maxTeam * maxPlayers;
  bool allow = true;

  for (var i in teams) {
    if (i.usersJob.length < maxPlayers) {
      allow = false;
      break;
    }
  }

  return !allow;
  // return join;
}

int getStringLength(String? value) {
  int length = 0;

  if (value != null) {
    length = value.length;
  }

  return length;
}

DateTime getSubscriptionTillTime() {
  return DateTime.now().add(Duration(days: 30));
}

double calculateGameUserRating(List<GameRoundUserRecord> gameRoundUser) {
  double ratingSum = 0;

  for (var i in gameRoundUser) {
    ratingSum += i.rating;
  }

  return ratingSum;
}

int calculateGameUserDeaths(List<GameRoundUserRecord> gameRoundUser) {
  int deathsSum = 0;

  for (var i in gameRoundUser) {
    if (i.isDead == true) {
      deathsSum = deathsSum + 1;
    }
  }

  return deathsSum;
}

double kd(
  int? kills,
  int? deth,
) {
  return (kills ?? 0) /
      (deth != null
          ? deth == 0
              ? 1
              : deth
          : 1);
}

int intIncrement(int value) {
  return value + 1;
}

bool ifIntInRange(
  int? value,
  int maxValue,
  int minValue,
) {
  int valueWithoutNull = value ?? 0;
  return valueWithoutNull <= maxValue && valueWithoutNull >= minValue;
}

List<UserJobStruct> setUserJob(
  DocumentReference user,
  List<UserJobStruct> userJobs,
  UserJobStruct newUserJob,
) {
  List<UserJobStruct> newUserJobs = [...userJobs];
  newUserJobs.removeWhere((e) => e.user == user);
  newUserJobs.add(newUserJob);

  //for (var j in newUserJobs) {
  //print("asdasdadadasdasdasd__${j.user?.id}__${j.job?.id}");
  //}

  return newUserJobs;
}

DateTime dateTimeCombined(
  DateTime date,
  DateTime time,
) {
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

double setProgressBarDouble(
  double? first,
  double second,
) {
  return (first ?? 0) / second;
}

String datesDifferenceEndRound(
  DateTime start,
  DateTime end,
) {
  Duration duration = start.difference(end).abs();

  // Получаем часы и минуты
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  // Форматируем в виде "часы:минуты"
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

DateTime getFirstDateOfSubsctiption(DateTime subscriptionTill) {
  return subscriptionTill.subtract(Duration(days: 30));
}

bool isAllowStartGame(
  List<TeamRecord> teams,
  int numbersOfPlayers,
) {
  bool allowStart = true;

  for (var i in teams) {
    if (i.usersJob.length < numbersOfPlayers) {
      allowStart = false;
      break;
    }
  }

  return allowStart;
}

bool allowToStartGame(
  List<DocumentReference> usersInGame,
  int maxTeam,
  int maxPlayers,
  List<TeamRecord> teams,
) {
  if (usersInGame.isEmpty) return false;
  // Достаточно, чтобы игроков было не меньше числа команд (по 1 на команду минимум)
  return usersInGame.length >= maxTeam;
}

DocumentReference? getMyTeamReferrence(
  DocumentReference user,
  List<TeamRecord> teams,
) {
  DocumentReference? ref;

  for (var i in teams) {
    if (i.creator == user) {
      ref = i.reference;
    }
  }

  return ref;
}

DocumentReference? geCapitanTeamReferrence(
  DocumentReference user,
  List<TeamRecord> teams,
) {
  DocumentReference? ref;

  for (var i in teams) {
    if (i.userCaptain == user) {
      ref = i.reference;
    }
  }

  return ref;
}

DocumentReference? getTeamIBelongsReference(
  DocumentReference user,
  List<TeamRecord> teams,
) {
  DocumentReference? ref;

  for (var i in teams) {
    for (var j in i.usersJob) {
      if (j.user == user) {
        ref = i.reference;
      }
    }
  }

  return ref;
}

List<UserJobStruct> changeUserJobs(
  DocumentReference userCaptain,
  DocumentReference user,
  List<UserJobStruct> userJobs,
) {
  List<UserJobStruct> newUserJobs = [...userJobs];
  late UserJobStruct job01;
  late UserJobStruct job02;

  for (var i in newUserJobs) {
    if (i.user == userCaptain) {
      // job01 = i;
      job01 = UserJobStruct(user: i.user, job: i.job);
    }
    if (i.user == user) {
      // job02 = i;
      job02 = UserJobStruct(user: i.user, job: i.job);
    }
  }

  newUserJobs.removeWhere((e) => e.user == userCaptain || e.user == user);

  newUserJobs.add(UserJobStruct(user: job01.user, job: job02.job));

  newUserJobs.add(UserJobStruct(user: job02.user, job: job01.job));

  // for (var i in newUserJobs) {
  //   if (i.user == userCaptain) {
  //     i.job = job02.job;
  //   }
  //   if (i.user == user) {
  //     i.job = job01.job;
  //   }
  // }

  return newUserJobs;
}

int decrement(int value) {
  return value - 1;
}

bool allPlayersReadyForGame(List<GameRoundUserRecord> gameUserRoundList) {
  bool allow = true;

  for (var i in gameUserRoundList) {
    if (!i.isReady) {
      allow = false;
      break;
    }
  }

  return allow;
}

DocumentReference? isRoundOver(
  List<TeamRecord> teams,
  List<GameRoundUserRecord> gameRoundUsers,
) {
  List<TeamRecord> teamsPotentiallyWinners = [];

  for (var i in teams) {
    int userDeathsCounter = 0;
    for (var j in i.usersJob) {
      for (var k in gameRoundUsers) {
        if (k.user == j.user && k.isDead) {
          userDeathsCounter++;
        }
      }
    }
    if (userDeathsCounter == i.usersJob.length) {
    } else {
      teamsPotentiallyWinners.add(i);
    }
  }

  if (teamsPotentiallyWinners.length == 1) {
    return teamsPotentiallyWinners.first.reference;
  }
  return null;
}

double calculatingRatingRound(
  int kills,
  int coefficent,
  DocumentReference teamWinnerRef,
  DocumentReference userTeam,
) {
  double bonus = 0;

  if (userTeam == teamWinnerRef) {
    bonus = 2;
  }

  double rateUser = (kills * coefficent) + bonus;

  return rateUser;
}

int datesDifference(
  DateTime currentDateTime,
  DateTime startDateTime,
) {
  int millisecondsDifference =
      currentDateTime.difference(startDateTime).inMilliseconds;

  return millisecondsDifference.abs();
}

int calculateGameUserKills(List<GameRoundUserRecord> gameRoundUser) {
  int killsSum = 0;

  for (var i in gameRoundUser) {
    killsSum += i.kills;
  }

  return killsSum;
}

int getTeamGameTotalWins(
  DocumentReference team,
  List<GameRoundRecord> gameRoundList,
) {
  int count = 0;

  for (var i in gameRoundList) {
    if (i.teamWinner == team) {
      count++;
    }
  }

  return count;
}

double calculateUserTotalRating(
  double? userRating,
  double ratingToAdd,
) {
  return (userRating ?? 0) + ratingToAdd;
}

int totalKillsDeath(
  int? userDeathKills,
  int killsDeathToAdd,
) {
  return (userDeathKills ?? 0) + killsDeathToAdd;
}

int totalWiner(
  int? userWin,
  List<DocumentReference> teamWinners,
  DocumentReference userTeam,
) {
  int winsCount = 0;

  for (var i in teamWinners) {
    if (i == userTeam) {
      winsCount++;
    }
  }

  return (userWin ?? 0) + winsCount;
}

int totalLoses(
  int? userLose,
  List<DocumentReference> teamWinners,
  DocumentReference userTeam,
) {
  int winsCount = 0;

  for (var i in teamWinners) {
    if (i == userTeam) {
      winsCount++;
    }
  }

  if (winsCount == 0) {
    return (userLose ?? 0) + 1;
  }

  return userLose ?? 0;
}

DocumentReference returnCurrUser(
  List<DocumentReference> users,
  DocumentReference curUser,
) {
  DocumentReference interlocutor = curUser;

  for (var i in users) {
    if (i != curUser) {
      interlocutor = i;
    }
  }

  return interlocutor;
}

double setProgressBarINT(
  int? first,
  int second,
) {
  return (first ?? 0) / second;
}

int calculateMaxWinSeries(List<bool>? seriesNoLosess) {
  if (seriesNoLosess == null || seriesNoLosess.isEmpty) return 0;

  int maxSeries = 0;
  int currentSeries = 0;

  for (final win in seriesNoLosess) {
    if (win) {
      currentSeries++;
      if (currentSeries > maxSeries) {
        maxSeries = currentSeries;
      }
    } else {
      currentSeries = 0;
    }
  }

  return maxSeries;
}

int getCurrentUserRatePlace(
  List<UserRecord> users,
  DocumentReference currentUser,
) {
  int indexPlace = 0;

  for (var i in users) {
    if (i.reference == currentUser) {
      break;
    }
    indexPlace++;
  }
  return indexPlace + 1;
}

List<DocumentReference> returnListUser(
  DocumentReference currUser,
  DocumentReference secundUser,
) {
  return [currUser, secundUser];
}

DocumentReference getUserReferenceById(String userId) {
  return FirebaseFirestore.instance.collection('User').doc(userId);
}

String emptyString() {
  return "";
}

bool checkUserInOtherTeam(
  List<TeamRecord> teamList,
  DocumentReference user,
) {
  bool userInOtherTeam = false;

  for (var i in teamList) {
    for (var j in i.usersJob) {
      if (j.user == user) {
        userInOtherTeam = true;
        break;
      }
    }
  }

  return userInOtherTeam;
}

List<Color> getColorsListsDifference(
  List<Color> list1,
  List<Color> list2,
) {
  return list1.where((color) => !list2.contains(color)).toList();
}

int twoIntProduct(
  int int01,
  int int02,
) {
  return int01 * int02;
}
