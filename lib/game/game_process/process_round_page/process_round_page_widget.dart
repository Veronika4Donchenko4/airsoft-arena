import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/plus_minys_bottom/plus_minys_bottom_widget.dart';
import '/dialog/are_you_killed_dialog/are_you_killed_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'process_round_page_model.dart';
export 'process_round_page_model.dart';

class ProcessRoundPageWidget extends StatefulWidget {
  const ProcessRoundPageWidget({super.key});

  static String routeName = 'ProcessRoundPage';
  static String routePath = '/processRoundPage';

  @override
  State<ProcessRoundPageWidget> createState() => _ProcessRoundPageWidgetState();
}

class _ProcessRoundPageWidgetState extends State<ProcessRoundPageWidget> {
  late ProcessRoundPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProcessRoundPageModel());

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
          child: StreamBuilder<List<GameRecord>>(
            stream: queryGameRecord(
              queryBuilder: (gameRecord) => gameRecord
                  .where(
                    'status',
                    isEqualTo: 2,
                  )
                  .where(
                    'users',
                    arrayContains: currentUserReference,
                  ),
              singleRecord: true,
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                );
              }
              List<GameRecord> containerGameRecordList = snapshot.data!;
              // Return an empty Container when the item does not exist.
              if (snapshot.data!.isEmpty) {
                return Container();
              }
              final containerGameRecord = containerGameRecordList.isNotEmpty
                  ? containerGameRecordList.first
                  : null;

              return Container(
                decoration: BoxDecoration(),
                child: StreamBuilder<List<GameRoundRecord>>(
                  stream: queryGameRoundRecord(
                    queryBuilder: (gameRoundRecord) => gameRoundRecord.where(
                      'game',
                      isEqualTo: containerGameRecord?.reference,
                    ),
                  )..listen((snapshot) {
                      List<GameRoundRecord> containerGameRoundRecordList =
                          snapshot;
                      if (_model.containerPreviousSnapshot != null &&
                          !const ListEquality(GameRoundRecordDocumentEquality())
                              .equals(containerGameRoundRecordList,
                                  _model.containerPreviousSnapshot)) {
                        () async {
                          if (containerGameRoundRecordList
                                  .sortedList(
                                      keyOf: (e) => e.createdTime!, desc: false)
                                  .lastOrNull
                                  ?.status ==
                              2) {
                            context.goNamed(
                              EndRoundPageWidget.routeName,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          }

                          safeSetState(() {});
                        }();
                      }
                      _model.containerPreviousSnapshot = snapshot;
                    }),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 30.0,
                          height: 30.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }
                    List<GameRoundRecord> containerGameRoundRecordList =
                        snapshot.data!;

                    return Container(
                      decoration: BoxDecoration(),
                      child: StreamBuilder<List<GameRoundUserRecord>>(
                        stream: queryGameRoundUserRecord(
                          queryBuilder: (gameRoundUserRecord) =>
                              gameRoundUserRecord
                                  .where(
                                    'game',
                                    isEqualTo: containerGameRecord?.reference,
                                  )
                                  .where(
                                    'user',
                                    isEqualTo: currentUserReference,
                                  )
                                  .where(
                                    'roundReference',
                                    isEqualTo: containerGameRoundRecordList
                                        .sortedList(
                                            keyOf: (e) => e.createdTime!,
                                            desc: false)
                                        .lastOrNull
                                        ?.reference,
                                  ),
                          singleRecord: true,
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 30.0,
                                height: 30.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          List<GameRoundUserRecord>
                              containerGameRoundUserRecordList = snapshot.data!;
                          // Return an empty Container when the item does not exist.
                          if (snapshot.data!.isEmpty) {
                            return Container();
                          }
                          final containerGameRoundUserRecord =
                              containerGameRoundUserRecordList.isNotEmpty
                                  ? containerGameRoundUserRecordList.first
                                  : null;

                          return StreamBuilder<List<GameRoundUserRecord>>(
                            stream: queryGameRoundUserRecord(
                              queryBuilder: (q) => q
                                  .where(
                                    'game',
                                    isEqualTo:
                                        containerGameRecord?.reference,
                                  )
                                  .where(
                                    'roundReference',
                                    isEqualTo:
                                        containerGameRoundRecordList
                                            .sortedList(
                                                keyOf: (e) =>
                                                    e.createdTime!,
                                                desc: false)
                                            .lastOrNull
                                            ?.reference,
                                  ),
                            ),
                            builder: (context, allRoundSnapshot) {
                              final allRoundUsers =
                                  allRoundSnapshot.data ?? [];
                              final opponentAliveCount = allRoundUsers
                                  .where((r) =>
                                      r.team?.id !=
                                          containerGameRoundUserRecord
                                              ?.team?.id &&
                                      !r.isDead)
                                  .length;
                              return Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 16.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent2,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      24.0, 12.0, 24.0, 12.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    FFIcons.kgun2,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 20.0,
                                                  ),
                                                  Text(
                                                    'Раунд ${containerGameRecord?.roundsRefs?.length?.toString()}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 20.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 8.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  FFIcons.ktimer,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 14.0,
                                                ),
                                                Text(
                                                  'Время раунда:',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 17.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          2.0, 0.0, 0.0, 0.0),
                                                  child: Container(
                                                    width: 63.0,
                                                    height: 18.0,
                                                    child: custom_widgets
                                                        .CustomTimer(
                                                      width: 63.0,
                                                      height: 18.0,
                                                      startTime:
                                                          containerGameRoundRecordList
                                                              .sortedList(
                                                                  keyOf: (e) =>
                                                                      e.createdTime!,
                                                                  desc: false)
                                                              .lastOrNull!
                                                              .startDateTime!,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (containerGameRoundUserRecord
                                                  ?.isDead ??
                                              true)
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Text(
                                                'Выбыли из раунда',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 17.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 16.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .accent2,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 20.0, 0.0, 0.0),
                                            child: Text(
                                              'Количество убийств',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              wrapWithModel(
                                                model: _model
                                                    .plusMinysBottomModel1,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: PlusMinysBottomWidget(
                                                  withPlus: false,
                                                  isActiv:
                                                      !containerGameRoundUserRecord!
                                                              .isDead &&
                                                          (_model.killsCounter >
                                                              0),
                                                  action: () async {
                                                    _model.killsCounter =
                                                        _model.killsCounter +
                                                            -1;
                                                    safeSetState(() {});

                                                    await containerGameRoundUserRecord!
                                                        .reference
                                                        .update(
                                                            createGameRoundUserRecordData(
                                                      kills:
                                                          _model.killsCounter,
                                                    ));
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.killsCounter
                                                        .toString(),
                                                    '0',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 34.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                              wrapWithModel(
                                                model: _model
                                                    .plusMinysBottomModel2,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: PlusMinysBottomWidget(
                                                  withPlus: true,
                                                  isActiv:
                                                      !containerGameRoundUserRecord!
                                                          .isDead &&
                                                      _model.killsCounter <
                                                          opponentAliveCount,
                                                  action: () async {
                                                    _model.killsCounter =
                                                        _model.killsCounter + 1;
                                                    safeSetState(() {});

                                                    await containerGameRoundUserRecord!
                                                        .reference
                                                        .update(
                                                            createGameRoundUserRecordData(
                                                      kills:
                                                          _model.killsCounter,
                                                    ));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (!containerGameRoundUserRecord!.isDead)
                                        Builder(
                                          builder: (context) => wrapWithModel(
                                            model: _model.generalButtomModel,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: GeneralButtomWidget(
                                              title: 'Я убит',
                                              isActive: true,
                                              height: 64.0,
                                              ignoreIsActive: false,
                                              onTap: () async {
                                                await showDialog(
                                                  context: context,
                                                  builder: (dialogContext) {
                                                    return Dialog(
                                                      elevation: 0,
                                                      insetPadding:
                                                          EdgeInsets.zero,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      alignment:
                                                          AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                      child: WebViewAware(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    dialogContext)
                                                                .unfocus();
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child:
                                                              AreYouKilledDialogWidget(
                                                            gameRoundUserDoc:
                                                                containerGameRoundUserRecord!,
                                                            killsNumber: _model
                                                                .killsCounter,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      if (containerGameRoundUserRecord
                                              ?.isDead ??
                                          true)
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0x1CFF453A),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 21.0, 0.0, 21.0),
                                            child: Text(
                                              'Вы убиты',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    fontSize: 17.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ),
                                    ].addToEnd(SizedBox(height: 16.0)),
                                  ),
                                ],
                              ),
                            ),
                          );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
