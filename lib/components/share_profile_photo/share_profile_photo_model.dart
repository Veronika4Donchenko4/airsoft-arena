import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/achievement_item_smoll/achievement_item_smoll_widget.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'share_profile_photo_widget.dart' show ShareProfilePhotoWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShareProfilePhotoModel extends FlutterFlowModel<ShareProfilePhotoWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for gameStatusListener component.
  late GameStatusListenerModel gameStatusListenerModel;
  // Models for achievement_item_smoll dynamic component.
  late FlutterFlowDynamicModels<AchievementItemSmollModel>
      achievementItemSmollModels;

  @override
  void initState(BuildContext context) {
    gameStatusListenerModel =
        createModel(context, () => GameStatusListenerModel());
    achievementItemSmollModels =
        FlutterFlowDynamicModels(() => AchievementItemSmollModel());
  }

  @override
  void dispose() {
    gameStatusListenerModel.dispose();
    achievementItemSmollModels.dispose();
  }
}
