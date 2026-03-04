import '/components/app_bar/app_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'game_place_page_model.dart';
export 'game_place_page_model.dart';

class GamePlacePageWidget extends StatefulWidget {
  const GamePlacePageWidget({super.key});

  static String routeName = 'GamePlacePage';
  static String routePath = '/gamePlacePage';

  @override
  State<GamePlacePageWidget> createState() => _GamePlacePageWidgetState();
}

class _GamePlacePageWidgetState extends State<GamePlacePageWidget> {
  late GamePlacePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GamePlacePageModel());

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
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.appBarModel,
                updateCallback: () => safeSetState(() {}),
                child: AppBarWidget(
                  title: 'Выберите место проведения',
                  withoutDots: true,
                  action: () async {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
