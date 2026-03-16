import '/backend/backend.dart';
import '/components/achievement_item/achievement_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'player_profile_page_widget.dart' show PlayerProfilePageWidget;
import 'package:flutter/material.dart';

class PlayerProfilePageModel
    extends FlutterFlowModel<PlayerProfilePageWidget> {
  // Models for achievement_item dynamic component.
  late FlutterFlowDynamicModels<AchievementItemModel> achievementItemModels;

  @override
  void initState(BuildContext context) {
    achievementItemModels =
        FlutterFlowDynamicModels(() => AchievementItemModel());
  }

  @override
  void dispose() {
    achievementItemModels.dispose();
  }
}
