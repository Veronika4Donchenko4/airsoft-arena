import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'start_game_page_widget.dart' show StartGamePageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StartGamePageModel extends FlutterFlowModel<StartGamePageWidget> {
  ///  State fields for stateful widgets in this page.

  List<GameRoundRecord>? containerPreviousSnapshot;
  // Model for gameStatusListener component.
  late GameStatusListenerModel gameStatusListenerModel;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel1;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel2;

  @override
  void initState(BuildContext context) {
    gameStatusListenerModel =
        createModel(context, () => GameStatusListenerModel());
    generalButtomModel1 = createModel(context, () => GeneralButtomModel());
    generalButtomModel2 = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    gameStatusListenerModel.dispose();
    generalButtomModel1.dispose();
    generalButtomModel2.dispose();
  }
}
