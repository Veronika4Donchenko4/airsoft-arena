import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/plus_minys_bottom/plus_minys_bottom_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'edit_death_widget.dart' show EditDeathWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditDeathModel extends FlutterFlowModel<EditDeathWidget> {
  ///  Local state fields for this component.

  int deathCounter = 0;

  ///  State fields for stateful widgets in this component.

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
