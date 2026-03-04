import '/components/general_buttom/general_buttom_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'type_complaint_player_widget.dart' show TypeComplaintPlayerWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TypeComplaintPlayerModel
    extends FlutterFlowModel<TypeComplaintPlayerWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;

  @override
  void initState(BuildContext context) {
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    generalButtomModel.dispose();
  }
}
