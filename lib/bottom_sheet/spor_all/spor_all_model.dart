import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/bottom_sheet/description_spore/description_spore_widget.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/radio_bottom/radio_bottom_widget.dart';
import '/dialog/notification/notification_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'spor_all_widget.dart' show SporAllWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class SporAllModel extends FlutterFlowModel<SporAllWidget> {
  ///  Local state fields for this component.

  DocumentReference? sporeVariantSelect;

  ///  State fields for stateful widgets in this component.

  // Models for radioBottom dynamic component.
  late FlutterFlowDynamicModels<RadioBottomModel> radioBottomModels;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;
  // Stores action output result for [Backend Call - Create Document] action in general_buttom widget.
  SporeRecord? userSpore;

  @override
  void initState(BuildContext context) {
    radioBottomModels = FlutterFlowDynamicModels(() => RadioBottomModel());
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    radioBottomModels.dispose();
    generalButtomModel.dispose();
  }
}
