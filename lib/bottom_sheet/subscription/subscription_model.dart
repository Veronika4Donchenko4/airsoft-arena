import '/backend/backend.dart';
import '/bottom_sheet/pay_subscription/pay_subscription_widget.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/subscription_item/subscription_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'subscription_widget.dart' show SubscriptionWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class SubscriptionModel extends FlutterFlowModel<SubscriptionWidget> {
  ///  Local state fields for this component.

  DocumentReference? subscriptionSelected;

  ///  State fields for stateful widgets in this component.

  // Models for subscription_item dynamic component.
  late FlutterFlowDynamicModels<SubscriptionItemModel> subscriptionItemModels;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;

  @override
  void initState(BuildContext context) {
    subscriptionItemModels =
        FlutterFlowDynamicModels(() => SubscriptionItemModel());
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    subscriptionItemModels.dispose();
    generalButtomModel.dispose();
  }
}
