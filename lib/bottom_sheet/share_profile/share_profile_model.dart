import '/auth/firebase_auth/auth_util.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/share_profile_photo/share_profile_photo_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'share_profile_widget.dart' show ShareProfileWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareProfileModel extends FlutterFlowModel<ShareProfileWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for share_profile_photo component.
  late ShareProfilePhotoModel shareProfilePhotoModel;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;

  @override
  void initState(BuildContext context) {
    shareProfilePhotoModel =
        createModel(context, () => ShareProfilePhotoModel());
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    shareProfilePhotoModel.dispose();
    generalButtomModel.dispose();
  }
}
