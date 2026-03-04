import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/dialog/notification/notification_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'description_spore_widget.dart' show DescriptionSporeWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class DescriptionSporeModel extends FlutterFlowModel<DescriptionSporeWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextFieldDescription widget.
  FocusNode? textFieldDescriptionFocusNode;
  TextEditingController? textFieldDescriptionTextController;
  String? Function(BuildContext, String?)?
      textFieldDescriptionTextControllerValidator;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;
  // Stores action output result for [Backend Call - Create Document] action in general_buttom widget.
  SporeRecord? newSpore;

  @override
  void initState(BuildContext context) {
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    textFieldDescriptionFocusNode?.dispose();
    textFieldDescriptionTextController?.dispose();

    generalButtomModel.dispose();
  }
}
