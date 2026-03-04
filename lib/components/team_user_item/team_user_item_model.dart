import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'team_user_item_widget.dart' show TeamUserItemWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TeamUserItemModel extends FlutterFlowModel<TeamUserItemWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<DialogRecord>? dialogList;
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  DialogRecord? dialogCreated;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
