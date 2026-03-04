import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/messages/messages_widget.dart';
import '/components/zero_item/zero_item_widget.dart';
import '/dialog/block_user/block_user_widget.dart';
import '/dialog/unblock_user/unblock_user_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dialog_page_widget.dart' show DialogPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class DialogPageModel extends FlutterFlowModel<DialogPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for messages dynamic component.
  late FlutterFlowDynamicModels<MessagesModel> messagesModels;
  bool isDataUploading_uploadDataVi3 = false;
  FFUploadedFile uploadedLocalFile_uploadDataVi3 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataVi3 = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  DialogMessageRecord? newMessage;

  @override
  void initState(BuildContext context) {
    messagesModels = FlutterFlowDynamicModels(() => MessagesModel());
  }

  @override
  void dispose() {
    messagesModels.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
