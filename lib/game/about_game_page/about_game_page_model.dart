import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/bottom_sheet/create_edit_team/create_edit_team_widget.dart';
import '/bottom_sheet/team_list/team_list_widget.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/switch_item/switch_item_widget.dart';
import '/components/team_user_item/team_user_item_widget.dart';
import '/dialog/action_game_dialog/action_game_dialog_widget.dart';
import '/dialog/confirmation_game_dialog/confirmation_game_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'about_game_page_widget.dart' show AboutGamePageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class AboutGamePageModel extends FlutterFlowModel<AboutGamePageWidget> {
  ///  Local state fields for this page.

  DocumentReference? teamSelected;

  ///  State fields for stateful widgets in this page.

  // Models for switch_item dynamic component.
  late FlutterFlowDynamicModels<SwitchItemModel> switchItemModels;
  // Models for teamUser_item dynamic component.
  late FlutterFlowDynamicModels<TeamUserItemModel> teamUserItemModels;
  // Model for gameStatusListener component.
  late GameStatusListenerModel gameStatusListenerModel;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel1;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel2;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel3;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel4;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel5;

  @override
  void initState(BuildContext context) {
    switchItemModels = FlutterFlowDynamicModels(() => SwitchItemModel());
    teamUserItemModels = FlutterFlowDynamicModels(() => TeamUserItemModel());
    gameStatusListenerModel =
        createModel(context, () => GameStatusListenerModel());
    generalButtomModel1 = createModel(context, () => GeneralButtomModel());
    generalButtomModel2 = createModel(context, () => GeneralButtomModel());
    generalButtomModel3 = createModel(context, () => GeneralButtomModel());
    generalButtomModel4 = createModel(context, () => GeneralButtomModel());
    generalButtomModel5 = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    switchItemModels.dispose();
    teamUserItemModels.dispose();
    gameStatusListenerModel.dispose();
    generalButtomModel1.dispose();
    generalButtomModel2.dispose();
    generalButtomModel3.dispose();
    generalButtomModel4.dispose();
    generalButtomModel5.dispose();
  }
}
