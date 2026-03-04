import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/bottom_sheet/action_with_player/action_with_player_widget.dart';
import '/bottom_sheet/player_search/player_search_widget.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/team_user_item/team_user_item_widget.dart';
import '/dialog/action_team_dialog/action_team_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'team_page_widget.dart' show TeamPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class TeamPageModel extends FlutterFlowModel<TeamPageWidget> {
  ///  Local state fields for this page.

  UserJobStruct? userSelect;
  void updateUserSelectStruct(Function(UserJobStruct) updateFn) {
    updateFn(userSelect ??= UserJobStruct());
  }

  ///  State fields for stateful widgets in this page.

  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // Models for teamUser_item dynamic component.
  late FlutterFlowDynamicModels<TeamUserItemModel> teamUserItemModels;
  // Model for gameStatusListener component.
  late GameStatusListenerModel gameStatusListenerModel;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;

  @override
  void initState(BuildContext context) {
    teamUserItemModels = FlutterFlowDynamicModels(() => TeamUserItemModel());
    gameStatusListenerModel =
        createModel(context, () => GameStatusListenerModel());
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    teamUserItemModels.dispose();
    gameStatusListenerModel.dispose();
    generalButtomModel.dispose();
  }
}
