import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/bottom_sheet/share_profile/share_profile_widget.dart';
import '/components/achievement_item/achievement_item_widget.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'my_rate_page_widget.dart' show MyRatePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class MyRatePageModel extends FlutterFlowModel<MyRatePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for gameStatusListener component.
  late GameStatusListenerModel gameStatusListenerModel;
  // Models for achievement_item dynamic component.
  late FlutterFlowDynamicModels<AchievementItemModel> achievementItemModels;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    gameStatusListenerModel =
        createModel(context, () => GameStatusListenerModel());
    achievementItemModels =
        FlutterFlowDynamicModels(() => AchievementItemModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    gameStatusListenerModel.dispose();
    achievementItemModels.dispose();
    navbarModel.dispose();
  }
}
