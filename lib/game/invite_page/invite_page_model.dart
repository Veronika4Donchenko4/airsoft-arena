import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/bottom_sheet/invitation_to_team/invitation_to_team_widget.dart';
import '/components/app_bar/app_bar_widget.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'invite_page_widget.dart' show InvitePageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class InvitePageModel extends FlutterFlowModel<InvitePageWidget> {
  ///  State fields for stateful widgets in this page.

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
