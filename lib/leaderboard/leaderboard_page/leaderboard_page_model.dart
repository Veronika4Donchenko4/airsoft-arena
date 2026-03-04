import '/backend/backend.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/components/player_list_liderbord/player_list_liderbord_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'leaderboard_page_widget.dart' show LeaderboardPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LeaderboardPageModel extends FlutterFlowModel<LeaderboardPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for gameStatusListener component.
  late GameStatusListenerModel gameStatusListenerModel;
  // Models for player_list_liderbord dynamic component.
  late FlutterFlowDynamicModels<PlayerListLiderbordModel>
      playerListLiderbordModels;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    gameStatusListenerModel =
        createModel(context, () => GameStatusListenerModel());
    playerListLiderbordModels =
        FlutterFlowDynamicModels(() => PlayerListLiderbordModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    gameStatusListenerModel.dispose();
    playerListLiderbordModels.dispose();
    navbarModel.dispose();
  }
}
