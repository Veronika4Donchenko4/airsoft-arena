import '/components/app_bar/app_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'use_conditions_page_model.dart';
export 'use_conditions_page_model.dart';

class UseConditionsPageWidget extends StatefulWidget {
  const UseConditionsPageWidget({
    super.key,
    this.type,
  });

  final int? type;

  static String routeName = 'UseConditionsPage';
  static String routePath = '/useConditionsPage';

  @override
  State<UseConditionsPageWidget> createState() =>
      _UseConditionsPageWidgetState();
}

class _UseConditionsPageWidgetState extends State<UseConditionsPageWidget> {
  late UseConditionsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UseConditionsPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  wrapWithModel(
                    model: _model.appBarModel,
                    updateCallback: () => safeSetState(() {}),
                    child: AppBarWidget(
                      title: widget!.type == 0
                          ? 'Условия использования'
                          : 'Политика конфиденциальности',
                      withoutDots: true,
                      action: () async {},
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlutterFlowWebView(
                      content: widget!.type == 0
                          ? 'https://sites.google.com/view/airsoftarena-docs/условия-использования?authuser=0'
                          : 'https://sites.google.com/view/airsoftarena-docs/политика-конфиденциальности?authuser=0',
                      bypass: false,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      verticalScroll: false,
                      horizontalScroll: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
