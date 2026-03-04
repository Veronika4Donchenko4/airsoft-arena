import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/bottom_sheet/subscription/subscription_widget.dart';
import '/components/game_item/game_item_widget.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/components/zero_item/zero_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'games_club_page_widget.dart' show GamesClubPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class GamesClubPageModel extends FlutterFlowModel<GamesClubPageWidget> {
  ///  Local state fields for this page.

  int? gameStatys = 0;

  List<int> currentGameStatuses = [0, 2];
  void addToCurrentGameStatuses(int item) => currentGameStatuses.add(item);
  void removeFromCurrentGameStatuses(int item) =>
      currentGameStatuses.remove(item);
  void removeAtIndexFromCurrentGameStatuses(int index) =>
      currentGameStatuses.removeAt(index);
  void insertAtIndexInCurrentGameStatuses(int index, int item) =>
      currentGameStatuses.insert(index, item);
  void updateCurrentGameStatusesAtIndex(int index, Function(int) updateFn) =>
      currentGameStatuses[index] = updateFn(currentGameStatuses[index]);

  List<int> pastGameStatuses = [1];
  void addToPastGameStatuses(int item) => pastGameStatuses.add(item);
  void removeFromPastGameStatuses(int item) => pastGameStatuses.remove(item);
  void removeAtIndexFromPastGameStatuses(int index) =>
      pastGameStatuses.removeAt(index);
  void insertAtIndexInPastGameStatuses(int index, int item) =>
      pastGameStatuses.insert(index, item);
  void updatePastGameStatusesAtIndex(int index, Function(int) updateFn) =>
      pastGameStatuses[index] = updateFn(pastGameStatuses[index]);

  ///  State fields for stateful widgets in this page.

  // Models for game_item dynamic component.
  late FlutterFlowDynamicModels<GameItemModel> gameItemModels;
  // Model for gameStatusListener component.
  late GameStatusListenerModel gameStatusListenerModel;
  // Model for zero_item component.
  late ZeroItemModel zeroItemModel;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    gameItemModels = FlutterFlowDynamicModels(() => GameItemModel());
    gameStatusListenerModel =
        createModel(context, () => GameStatusListenerModel());
    zeroItemModel = createModel(context, () => ZeroItemModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    gameItemModels.dispose();
    gameStatusListenerModel.dispose();
    zeroItemModel.dispose();
    navbarModel.dispose();
  }
}
