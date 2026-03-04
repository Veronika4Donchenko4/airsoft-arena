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
import 'start_game_club_page_widget.dart' show StartGameClubPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StartGameClubPageModel extends FlutterFlowModel<StartGameClubPageWidget> {
  ///  Local state fields for this page.

  DocumentReference? teamSelect;

  int userCounter = 0;

  ///  State fields for stateful widgets in this page.

  // Models for switch_item dynamic component.
  late FlutterFlowDynamicModels<SwitchItemModel> switchItemModels;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;

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
