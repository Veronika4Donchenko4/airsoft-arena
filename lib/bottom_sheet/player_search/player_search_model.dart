import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'player_search_widget.dart' show PlayerSearchWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlayerSearchModel extends FlutterFlowModel<PlayerSearchWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Slider widget.
  double? sliderValue;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;
  // Stores action output result for [Firestore Query - Query a collection] action in general_buttom widget.
  List<UserRecord>? usersLoaded;

  @override
  void initState(BuildContext context) {
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    generalButtomModel.dispose();
  }
}
