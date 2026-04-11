import '/components/general_buttom/general_buttom_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'club_profile_page_widget.dart' show ClubProfilePageWidget;
import 'package:flutter/material.dart';

class ClubProfilePageModel extends FlutterFlowModel<ClubProfilePageWidget> {
  // Model for generalButtom component.
  late GeneralButtomModel generalButtomModel;

  @override
  void initState(BuildContext context) {
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    generalButtomModel.dispose();
  }
}
