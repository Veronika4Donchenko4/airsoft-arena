import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/switch_item/switch_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'result_round_glub_page_widget.dart' show ResultRoundGlubPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ResultRoundGlubPageModel
    extends FlutterFlowModel<ResultRoundGlubPageWidget> {
  ///  Local state fields for this page.

  DocumentReference? teamSelected;

  int usersSaveCounter = 0;

  List<DocumentReference> gameRoundUsers = [];
  void addToGameRoundUsers(DocumentReference item) => gameRoundUsers.add(item);
  void removeFromGameRoundUsers(DocumentReference item) =>
      gameRoundUsers.remove(item);
  void removeAtIndexFromGameRoundUsers(int index) =>
      gameRoundUsers.removeAt(index);
  void insertAtIndexInGameRoundUsers(int index, DocumentReference item) =>
      gameRoundUsers.insert(index, item);
  void updateGameRoundUsersAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      gameRoundUsers[index] = updateFn(gameRoundUsers[index]);

  ///  State fields for stateful widgets in this page.

  // Models for switch_item dynamic component.
  late FlutterFlowDynamicModels<SwitchItemModel> switchItemModels;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;
  // Stores action output result for [Backend Call - Create Document] action in general_buttom widget.
  GameRoundRecord? roundCreated;
  // Stores action output result for [Backend Call - Create Document] action in general_buttom widget.
  GameRoundUserRecord? gameRounUserSaved;

  @override
  void initState(BuildContext context) {
    switchItemModels = FlutterFlowDynamicModels(() => SwitchItemModel());
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    switchItemModels.dispose();
    generalButtomModel.dispose();
  }
}
