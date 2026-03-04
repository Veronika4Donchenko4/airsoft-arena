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

import '/auth/firebase_auth/auth_util.dart';

import 'package:geolocator/geolocator.dart';
import 'dart:async';

Future saveCurrentUserPosition() async {
  if (currentUserReference != null) {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // print('Службы геолокации отключены');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          // print('Доступ к геолокации запрещен');
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      await currentUserReference!.update(createUserRecordData(
        geoTag: LatLng(position.latitude, position.longitude),
      ));

      // print('Новые координаты: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      print('Ошибка получения координат: $e');
    }

    const Duration interval = Duration(minutes: 3);
    Timer.periodic(interval, (Timer timer) async {
      try {
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          // print('Службы геолокации отключены');
          return;
        }

        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission != LocationPermission.whileInUse &&
              permission != LocationPermission.always) {
            // print('Доступ к геолокации запрещен');
            return;
          }
        }

        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );

        await currentUserReference!.update(createUserRecordData(
          geoTag: LatLng(position.latitude, position.longitude),
        ));

        // print('Новые координаты: ${position.latitude}, ${position.longitude}');
      } catch (e) {
        print('Ошибка получения координат: $e');
      }
    });
  }
}
