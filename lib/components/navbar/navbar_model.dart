import '/auth/firebase_auth/auth_util.dart';
import '/components/navbar_item/navbar_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/index.dart';
import 'navbar_widget.dart' show NavbarWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NavbarModel extends FlutterFlowModel<NavbarWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for navbarItem component.
  late NavbarItemModel navbarItemModel1;
  // Model for navbarItem component.
  late NavbarItemModel navbarItemModel2;
  // Model for navbarItem component.
  late NavbarItemModel navbarItemModel3;
  // Model for navbarItem component.
  late NavbarItemModel navbarItemModel4;
  // Model for navbarItem component.
  late NavbarItemModel navbarItemModel5;

  @override
  void initState(BuildContext context) {
    navbarItemModel1 = createModel(context, () => NavbarItemModel());
    navbarItemModel2 = createModel(context, () => NavbarItemModel());
    navbarItemModel3 = createModel(context, () => NavbarItemModel());
    navbarItemModel4 = createModel(context, () => NavbarItemModel());
    navbarItemModel5 = createModel(context, () => NavbarItemModel());
  }

  @override
  void dispose() {
    navbarItemModel1.dispose();
    navbarItemModel2.dispose();
    navbarItemModel3.dispose();
    navbarItemModel4.dispose();
    navbarItemModel5.dispose();
  }
}
