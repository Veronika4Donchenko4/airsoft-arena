import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'router_page_widget.dart' show RouterPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RouterPageModel extends FlutterFlowModel<RouterPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in RouterPage widget.
  GameRecord? userActivGame;
  // Stores action output result for [Firestore Query - Query a collection] action in RouterPage widget.
  List<GameRoundRecord>? userGameRound;
  // Stores action output result for [Firestore Query - Query a collection] action in RouterPage widget.
  GameRecord? clubActivGame;
  // Stores action output result for [Firestore Query - Query a collection] action in RouterPage widget.
  List<GameRoundRecord>? clubGameRound;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
