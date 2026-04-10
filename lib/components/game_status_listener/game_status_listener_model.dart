import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'game_status_listener_widget.dart' show GameStatusListenerWidget;
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GameStatusListenerModel
    extends FlutterFlowModel<GameStatusListenerWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in gameStatusListener widget.
  GameRecord? userActivGame;
  // Stores action output result for [Firestore Query - Query a collection] action in gameStatusListener widget.
  List<GameRoundRecord>? userGameRound;
  // Stores action output result for [Firestore Query - Query a collection] action in gameStatusListener widget.
  GameRecord? clubActivGame;
  // Stores action output result for [Firestore Query - Query a collection] action in gameStatusListener widget.
  List<GameRoundRecord>? clubGameRound;
  List<GameRoundRecord>? containerPreviousSnapshot1;
  List<GameRoundRecord>? containerPreviousSnapshot2;
  StreamSubscription<List<GameRoundRecord>>? userGameRoundSubscription;
  StreamSubscription<List<GameRoundRecord>>? clubGameRoundSubscription;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    userGameRoundSubscription?.cancel();
    clubGameRoundSubscription?.cancel();
  }
}
