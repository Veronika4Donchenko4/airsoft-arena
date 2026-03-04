import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/app_bar/app_bar_widget.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'appli_list_game_page_widget.dart' show AppliListGamePageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AppliListGamePageModel extends FlutterFlowModel<AppliListGamePageWidget> {
  ///  State fields for stateful widgets in this page.

  GameRecord? containerPreviousSnapshot;
  // Model for app_bar component.
  late AppBarModel appBarModel;
  // Model for gameStatusListener component.
  late GameStatusListenerModel gameStatusListenerModel;

  @override
  void initState(BuildContext context) {
    appBarModel = createModel(context, () => AppBarModel());
    gameStatusListenerModel =
        createModel(context, () => GameStatusListenerModel());
  }

  @override
  void dispose() {
    appBarModel.dispose();
    gameStatusListenerModel.dispose();
  }
}
