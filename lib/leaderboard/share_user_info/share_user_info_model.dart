import '/backend/backend.dart';
import '/components/share_profile_photo/share_profile_photo_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'share_user_info_widget.dart' show ShareUserInfoWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShareUserInfoModel extends FlutterFlowModel<ShareUserInfoWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for share_profile_photo component.
  late ShareProfilePhotoModel shareProfilePhotoModel;

  @override
  void initState(BuildContext context) {
    shareProfilePhotoModel =
        createModel(context, () => ShareProfilePhotoModel());
  }

  @override
  void dispose() {
    shareProfilePhotoModel.dispose();
  }
}
