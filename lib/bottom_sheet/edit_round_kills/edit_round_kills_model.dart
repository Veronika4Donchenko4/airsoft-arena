import '/backend/backend.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/plus_minys_bottom/plus_minys_bottom_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'edit_round_kills_widget.dart' show EditRoundKillsWidget;
import 'package:flutter/material.dart';

class EditRoundKillsModel extends FlutterFlowModel<EditRoundKillsWidget> {
  ///  Local state fields for this component.

  int killsCounter = 0;

  ///  State fields for stateful widgets in this component.

  // Model for PlusMinysBottom component.
  late PlusMinysBottomModel plusMinysBottomModel1;
  // Model for PlusMinysBottom component.
  late PlusMinysBottomModel plusMinysBottomModel2;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;

  @override
  void initState(BuildContext context) {
    plusMinysBottomModel1 = createModel(context, () => PlusMinysBottomModel());
    plusMinysBottomModel2 = createModel(context, () => PlusMinysBottomModel());
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    plusMinysBottomModel1.dispose();
    plusMinysBottomModel2.dispose();
    generalButtomModel.dispose();
  }
}
