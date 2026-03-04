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

import 'dart:math';

Future sendInvitationsByDistance(
  List<UserRecord> users,
  double distance,
  DocumentReference team,
  DocumentReference game,
  LatLng coords,
) async {
  List<DocumentReference> usersBuffer = [];

  for (var i in users) {
    if (i.geoTag != null) {
      const double earthRadius = 6371000; // Радиус Земли в метрах

      // Переводим градусы в радианы
      double dLat = (i.geoTag!.latitude - coords.latitude) * pi / 180;
      double dLon = (i.geoTag!.longitude - coords.longitude) * pi / 180;

      // Вычисляем по формуле Haversine
      double a = pow(sin(dLat / 2), 2) +
          cos((i.geoTag!.latitude) * pi / 180) *
              cos((coords.latitude) * pi / 180) *
              pow(sin(dLon / 2), 2);
      double c = 2 * atan2(sqrt(a), sqrt(1 - a));

      // Расстояние в метрах
      double distanceToUser = earthRadius * c;

      if (distanceToUser <= distance) {
        usersBuffer.add(i.reference);
      }
    }
  }

  for (var i in usersBuffer) {
    await i.update({
      ...mapToFirestore(
        {
          'proposedGameTeam': FieldValue.arrayUnion([
            getProposedGameTeamFirestoreData(
              createProposedGameTeamStruct(
                team: team,
                game: game,
                clearUnsetFields: false,
              ),
              true,
            )
          ]),
        },
      ),
    });
  }
}
