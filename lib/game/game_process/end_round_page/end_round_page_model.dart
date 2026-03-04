import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/bottom_sheet/spor_all/spor_all_widget.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/team_result_item/team_result_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'end_round_page_widget.dart' show EndRoundPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class EndRoundPageModel extends FlutterFlowModel<EndRoundPageWidget> {
  ///  State fields for stateful widgets in this page.

  List<GameRecord>? containerPreviousSnapshot;
  // Models for team_result_item dynamic component.
  late FlutterFlowDynamicModels<TeamResultItemModel> teamResultItemModels;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel1;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel2;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel3;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel4;

  @override
  void initState(BuildContext context) {
    teamResultItemModels =
        FlutterFlowDynamicModels(() => TeamResultItemModel());
    generalButtomModel1 = createModel(context, () => GeneralButtomModel());
    generalButtomModel2 = createModel(context, () => GeneralButtomModel());
    generalButtomModel3 = createModel(context, () => GeneralButtomModel());
    generalButtomModel4 = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    teamResultItemModels.dispose();
    generalButtomModel1.dispose();
    generalButtomModel2.dispose();
    generalButtomModel3.dispose();
    generalButtomModel4.dispose();
  }
}
