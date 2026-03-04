import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/plus_minys_bottom/plus_minys_bottom_widget.dart';
import '/dialog/are_you_killed_dialog/are_you_killed_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'process_round_page_widget.dart' show ProcessRoundPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ProcessRoundPageModel extends FlutterFlowModel<ProcessRoundPageWidget> {
  ///  Local state fields for this page.

  int killsCounter = 0;

  ///  State fields for stateful widgets in this page.

  List<GameRoundRecord>? containerPreviousSnapshot;
  // Model for PlusMinysBottom component.
  late PlusMinysBottomModel plusMinysBottomModel1;
  // Model for PlusMinysBottom component.
  late PlusMinysBottomModel plusMinysBottomModel2;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;

  @override
  void initState(BuildContext context) {
    plusMinysBottomModel1 = createModel(context, () => PlusMinysBottomModel());
    plusMinysBottomModel2 = createModel(context, () => PlusMinysBottomModel());
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    plusMinysBottomModel1.dispose();
    plusMinysBottomModel2.dispose();
    generalButtomModel.dispose();
  }
}
