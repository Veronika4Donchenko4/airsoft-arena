import '/components/general_buttom/general_buttom_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'create_clan_widget.dart' show CreateClanWidget;
import 'package:flutter/material.dart';

class CreateClanModel extends FlutterFlowModel<CreateClanWidget> {
  // Flag image fields
  bool isDataUploading_flag = false;
  FFUploadedFile uploadedLocalFile_flag =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_flag = '';

  // Form/uniform image fields
  bool isDataUploading_form = false;
  FFUploadedFile uploadedLocalFile_form =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_form = '';

  // Name text field
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;

  // Slogan text field
  FocusNode? sloganFocusNode;
  TextEditingController? sloganTextController;
  String? Function(BuildContext, String?)? sloganTextControllerValidator;

  // Save button
  late GeneralButtomModel generalButtomModel;

  @override
  void initState(BuildContext context) {
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();
    sloganFocusNode?.dispose();
    sloganTextController?.dispose();
    generalButtomModel.dispose();
  }
}
