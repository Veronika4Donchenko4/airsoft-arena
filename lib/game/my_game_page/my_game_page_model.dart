import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/game_item/game_item_widget.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/components/zero_item/zero_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'my_game_page_widget.dart' show MyGamePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyGamePageModel extends FlutterFlowModel<MyGamePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for game_item dynamic component.
  late FlutterFlowDynamicModels<GameItemModel> gameItemModels;
  // Model for gameStatusListener component.
  late GameStatusListenerModel gameStatusListenerModel;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    gameItemModels = FlutterFlowDynamicModels(() => GameItemModel());
    gameStatusListenerModel =
        createModel(context, () => GameStatusListenerModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    gameItemModels.dispose();
    gameStatusListenerModel.dispose();
    navbarModel.dispose();
  }
}
