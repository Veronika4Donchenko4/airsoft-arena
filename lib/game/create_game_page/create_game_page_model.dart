import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/bottom_sheet/city_search_view/city_search_view_widget.dart';
import '/components/app_bar/app_bar_widget.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/dialog/notification/notification_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'create_game_page_widget.dart' show CreateGamePageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class CreateGamePageModel extends FlutterFlowModel<CreateGamePageWidget> {
  ///  Local state fields for this page.

  CityTypeStruct? citySselect;
  void updateCitySselectStruct(Function(CityTypeStruct) updateFn) {
    updateFn(citySselect ??= CityTypeStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Model for app_bar component.
  late AppBarModel appBarModel;
  // State field(s) for TextFieldDescription widget.
  FocusNode? textFieldDescriptionFocusNode1;
  TextEditingController? textFieldDescriptionTextController1;
  String? Function(BuildContext, String?)?
      textFieldDescriptionTextController1Validator;
  // State field(s) for TextFieldCity widget.
  FocusNode? textFieldCityFocusNode;
  TextEditingController? textFieldCityTextController;
  String? Function(BuildContext, String?)? textFieldCityTextControllerValidator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for TextFieldDescription widget.
  FocusNode? textFieldDescriptionFocusNode2;
  TextEditingController? textFieldDescriptionTextController2;
  String? Function(BuildContext, String?)?
      textFieldDescriptionTextController2Validator;
  // State field(s) for TextFieldDescription widget.
  FocusNode? textFieldDescriptionFocusNode3;
  TextEditingController? textFieldDescriptionTextController3;
  String? Function(BuildContext, String?)?
      textFieldDescriptionTextController3Validator;
  // State field(s) for TextFieldDescription widget.
  FocusNode? textFieldDescriptionFocusNode4;
  TextEditingController? textFieldDescriptionTextController4;
  String? Function(BuildContext, String?)?
      textFieldDescriptionTextController4Validator;
  // State field(s) for TextFieldDescription widget.
  FocusNode? textFieldDescriptionFocusNode5;
  TextEditingController? textFieldDescriptionTextController5;
  String? Function(BuildContext, String?)?
      textFieldDescriptionTextController5Validator;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel1;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel2;
  // Model for gameStatusListener component.
  late GameStatusListenerModel gameStatusListenerModel;

  @override
  void initState(BuildContext context) {
    appBarModel = createModel(context, () => AppBarModel());
    generalButtomModel1 = createModel(context, () => GeneralButtomModel());
    generalButtomModel2 = createModel(context, () => GeneralButtomModel());
    gameStatusListenerModel =
        createModel(context, () => GameStatusListenerModel());
  }

  @override
  void dispose() {
    appBarModel.dispose();
    textFieldDescriptionFocusNode1?.dispose();
    textFieldDescriptionTextController1?.dispose();

    textFieldCityFocusNode?.dispose();
    textFieldCityTextController?.dispose();

    textFieldDescriptionFocusNode2?.dispose();
    textFieldDescriptionTextController2?.dispose();

    textFieldDescriptionFocusNode3?.dispose();
    textFieldDescriptionTextController3?.dispose();

    textFieldDescriptionFocusNode4?.dispose();
    textFieldDescriptionTextController4?.dispose();

    textFieldDescriptionFocusNode5?.dispose();
    textFieldDescriptionTextController5?.dispose();

    generalButtomModel1.dispose();
    generalButtomModel2.dispose();
    gameStatusListenerModel.dispose();
  }
}
