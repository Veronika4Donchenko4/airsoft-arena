import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/switch_item/switch_item_widget.dart';
import '/components/team_result_item/team_result_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'result_game_glub_page_widget.dart' show ResultGameGlubPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ResultGameGlubPageModel
    extends FlutterFlowModel<ResultGameGlubPageWidget> {
  ///  Local state fields for this page.

  DocumentReference? teamSelected;

  int userCounter = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in ResultGameGlubPage widget.
  GameRecord? gameLoaded;
  // Stores action output result for [Custom Action - getUserFromRefList] action in ResultGameGlubPage widget.
  List<UserRecord>? userLoaded;
  // Models for team_result_item dynamic component.
  late FlutterFlowDynamicModels<TeamResultItemModel> teamResultItemModels;
  // Models for switch_item dynamic component.
  late FlutterFlowDynamicModels<SwitchItemModel> switchItemModels;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;
  // Stores action output result for [Firestore Query - Query a collection] action in general_buttom widget.
  List<AchievementRecord>? achivList;

  @override
  void initState(BuildContext context) {
    teamResultItemModels =
        FlutterFlowDynamicModels(() => TeamResultItemModel());
    switchItemModels = FlutterFlowDynamicModels(() => SwitchItemModel());
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    teamResultItemModels.dispose();
    switchItemModels.dispose();
    generalButtomModel.dispose();
  }
}
