import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/team_result_item/team_result_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'end_round_club_page_widget.dart' show EndRoundClubPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EndRoundClubPageModel extends FlutterFlowModel<EndRoundClubPageWidget> {
  ///  Local state fields for this page.

  int userSaveCounter = 0;

  List<DocumentReference> saveGameUserList = [];
  void addToSaveGameUserList(DocumentReference item) =>
      saveGameUserList.add(item);
  void removeFromSaveGameUserList(DocumentReference item) =>
      saveGameUserList.remove(item);
  void removeAtIndexFromSaveGameUserList(int index) =>
      saveGameUserList.removeAt(index);
  void insertAtIndexInSaveGameUserList(int index, DocumentReference item) =>
      saveGameUserList.insert(index, item);
  void updateSaveGameUserListAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      saveGameUserList[index] = updateFn(saveGameUserList[index]);

  ///  State fields for stateful widgets in this page.

  // Models for team_result_item dynamic component.
  late FlutterFlowDynamicModels<TeamResultItemModel> teamResultItemModels;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel1;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel2;
  // Stores action output result for [Backend Call - Create Document] action in general_buttom widget.
  GameUserRecord? gameUserSaved;
  // Stores action output result for [Custom Action - calculateGameWinners] action in general_buttom widget.
  List<DocumentReference>? gameTeamsWinners;
  // Stores action output result for [Firestore Query - Query a collection] action in general_buttom widget.
  List<GameRoundUserRecord>? gameRoundUserLoaded;

  @override
  void initState(BuildContext context) {
    teamResultItemModels =
        FlutterFlowDynamicModels(() => TeamResultItemModel());
    generalButtomModel1 = createModel(context, () => GeneralButtomModel());
    generalButtomModel2 = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    teamResultItemModels.dispose();
    generalButtomModel1.dispose();
    generalButtomModel2.dispose();
  }
}
