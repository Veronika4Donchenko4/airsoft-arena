import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/app_bar/app_bar_widget.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'my_games_page_widget.dart' show MyGamesPageWidget;
import 'package:flutter/material.dart';

class MyGamesPageModel extends FlutterFlowModel<MyGamesPageWidget> {
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
