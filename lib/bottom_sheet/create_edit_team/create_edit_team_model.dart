import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/color_choose_item/color_choose_item_widget.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/dialog/notification/notification_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'create_edit_team_widget.dart' show CreateEditTeamWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class CreateEditTeamModel extends FlutterFlowModel<CreateEditTeamWidget> {
  ///  Local state fields for this component.

  Color? colorSelected;

  ///  State fields for stateful widgets in this component.

  // Models for color_choose_item dynamic component.
  late FlutterFlowDynamicModels<ColorChooseItemModel> colorChooseItemModels;
  // State field(s) for TextFieldDescription widget.
  FocusNode? textFieldDescriptionFocusNode1;
  TextEditingController? textFieldDescriptionTextController1;
  String? Function(BuildContext, String?)?
      textFieldDescriptionTextController1Validator;
  // State field(s) for TextFieldDescription widget.
  FocusNode? textFieldDescriptionFocusNode2;
  TextEditingController? textFieldDescriptionTextController2;
  String? Function(BuildContext, String?)?
      textFieldDescriptionTextController2Validator;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;
  // Stores action output result for [Backend Call - Create Document] action in general_buttom widget.
  TeamRecord? teamCreated;

  @override
  void initState(BuildContext context) {
    colorChooseItemModels =
        FlutterFlowDynamicModels(() => ColorChooseItemModel());
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    colorChooseItemModels.dispose();
    textFieldDescriptionFocusNode1?.dispose();
    textFieldDescriptionTextController1?.dispose();

    textFieldDescriptionFocusNode2?.dispose();
    textFieldDescriptionTextController2?.dispose();

    generalButtomModel.dispose();
  }
}
