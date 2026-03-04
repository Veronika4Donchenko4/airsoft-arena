import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'confirmation_game_dialog_widget.dart' show ConfirmationGameDialogWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ConfirmationGameDialogModel
    extends FlutterFlowModel<ConfirmationGameDialogWidget> {
  ///  Local state fields for this component.

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

  int usersSaveCounter = 0;

  bool load = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  GameRoundRecord? roundCreated;
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  GameRoundUserRecord? gameRounUserSaved;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
