import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/structs/index.dart';
import '/bottom_sheet/city_search_view/city_search_view_widget.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/index.dart';
import 'create_profile_widget.dart' show CreateProfileWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class CreateProfileModel extends FlutterFlowModel<CreateProfileWidget> {
  ///  Local state fields for this page.

  int typeUser = 0;

  CityTypeStruct? citySelected;
  void updateCitySelectedStruct(Function(CityTypeStruct) updateFn) {
    updateFn(citySelected ??= CityTypeStruct());
  }

  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadDataUserImage = false;
  FFUploadedFile uploadedLocalFile_uploadDataUserImage =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel1;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel2;
  // State field(s) for TextFieldNickname widget.
  FocusNode? textFieldNicknameFocusNode;
  TextEditingController? textFieldNicknameTextController;
  String? Function(BuildContext, String?)?
      textFieldNicknameTextControllerValidator;
  // State field(s) for TextFieldClubName widget.
  FocusNode? textFieldClubNameFocusNode;
  TextEditingController? textFieldClubNameTextController;
  String? Function(BuildContext, String?)?
      textFieldClubNameTextControllerValidator;
  // State field(s) for TextFieldCity widget.
  FocusNode? textFieldCityFocusNode;
  TextEditingController? textFieldCityTextController;
  String? Function(BuildContext, String?)? textFieldCityTextControllerValidator;
  // State field(s) for TextFieldDescription widget.
  FocusNode? textFieldDescriptionFocusNode;
  TextEditingController? textFieldDescriptionTextController;
  String? Function(BuildContext, String?)?
      textFieldDescriptionTextControllerValidator;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel3;
  bool isDataUploading_uploadDataHgy = false;
  FFUploadedFile uploadedLocalFile_uploadDataHgy =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataHgy = '';

  @override
  void initState(BuildContext context) {
    generalButtomModel1 = createModel(context, () => GeneralButtomModel());
    generalButtomModel2 = createModel(context, () => GeneralButtomModel());
    generalButtomModel3 = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    generalButtomModel1.dispose();
    generalButtomModel2.dispose();
    textFieldNicknameFocusNode?.dispose();
    textFieldNicknameTextController?.dispose();

    textFieldClubNameFocusNode?.dispose();
    textFieldClubNameTextController?.dispose();

    textFieldCityFocusNode?.dispose();
    textFieldCityTextController?.dispose();

    textFieldDescriptionFocusNode?.dispose();
    textFieldDescriptionTextController?.dispose();

    generalButtomModel3.dispose();
  }
}
