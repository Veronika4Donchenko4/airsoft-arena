import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/bottom_sheet/subscription/subscription_widget.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/dialog/exit_dialog/exit_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  ///  Local state fields for this page.

  String version = '-';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getAppVersion] action in ProfilePage widget.
  String? versionOutput;
  // Model for gameStatusListener component.
  late GameStatusListenerModel gameStatusListenerModel;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    gameStatusListenerModel =
        createModel(context, () => GameStatusListenerModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    gameStatusListenerModel.dispose();
    navbarModel.dispose();
  }
}
