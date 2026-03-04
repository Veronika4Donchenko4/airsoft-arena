import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/bottom_sheet/edit_player/edit_player_widget.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/spore_item/spore_item_widget.dart';
import '/components/switch_item/switch_item_widget.dart';
import '/components/team_accpset_statys_item/team_accpset_statys_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'acc_result_game_club_page_widget.dart' show AccResultGameClubPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class AccResultGameClubPageModel
    extends FlutterFlowModel<AccResultGameClubPageWidget> {
  ///  Local state fields for this page.

  DocumentReference? teamSelect;

  List<DocumentReference> gameUser = [];
  void addToGameUser(DocumentReference item) => gameUser.add(item);
  void removeFromGameUser(DocumentReference item) => gameUser.remove(item);
  void removeAtIndexFromGameUser(int index) => gameUser.removeAt(index);
  void insertAtIndexInGameUser(int index, DocumentReference item) =>
      gameUser.insert(index, item);
  void updateGameUserAtIndex(int index, Function(DocumentReference) updateFn) =>
      gameUser[index] = updateFn(gameUser[index]);

  ///  State fields for stateful widgets in this page.

  // Models for team_accpset_statys_item dynamic component.
  late FlutterFlowDynamicModels<TeamAccpsetStatysItemModel>
      teamAccpsetStatysItemModels;
  // Models for spore_item dynamic component.
  late FlutterFlowDynamicModels<SporeItemModel> sporeItemModels;
  // Models for switch_item dynamic component.
  late FlutterFlowDynamicModels<SwitchItemModel> switchItemModels;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;
  // Stores action output result for [Custom Action - calculateGameWinners] action in general_buttom widget.
  List<DocumentReference>? gameTeamsWinners;
  // Stores action output result for [Custom Action - calculateGameWinners] action in Container widget.
  List<DocumentReference>? gameTeamsWinner;

  @override
  void initState(BuildContext context) {
    teamAccpsetStatysItemModels =
        FlutterFlowDynamicModels(() => TeamAccpsetStatysItemModel());
    sporeItemModels = FlutterFlowDynamicModels(() => SporeItemModel());
    switchItemModels = FlutterFlowDynamicModels(() => SwitchItemModel());
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    teamAccpsetStatysItemModels.dispose();
    sporeItemModels.dispose();
    switchItemModels.dispose();
    generalButtomModel.dispose();
  }
}
