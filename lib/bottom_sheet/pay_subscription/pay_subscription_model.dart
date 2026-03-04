import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/bottom_sheet/subscription/subscription_widget.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/subscription_item/subscription_item_widget.dart';
import '/dialog/notification/notification_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'pay_subscription_widget.dart' show PaySubscriptionWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class PaySubscriptionModel extends FlutterFlowModel<PaySubscriptionWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for subscription_item component.
  late SubscriptionItemModel subscriptionItemModel;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;

  @override
  void initState(BuildContext context) {
    subscriptionItemModel = createModel(context, () => SubscriptionItemModel());
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    subscriptionItemModel.dispose();
    generalButtomModel.dispose();
  }
}
