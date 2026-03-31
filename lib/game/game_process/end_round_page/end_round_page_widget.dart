import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/bottom_sheet/spor_all/spor_all_widget.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/team_result_item/team_result_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'end_round_page_model.dart';
export 'end_round_page_model.dart';

class EndRoundPageWidget extends StatefulWidget {
  const EndRoundPageWidget({super.key});

  static String routeName = 'EndRoundPage';
  static String routePath = '/endRoundPage';

  @override
  State<EndRoundPageWidget> createState() => _EndRoundPageWidgetState();
}

class _EndRoundPageWidgetState extends State<EndRoundPageWidget> {
  late EndRoundPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EndRoundPageModel());

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
            )..listen((snapshot) {
                List<GameRecord> containerGameRecordList = snapshot;
                final containerGameRecord = containerGameRecordList.isNotEmpty
                    ? containerGameRecordList.first
                    : null;
                if (_model.containerPreviousSnapshot != null &&
                    !const ListEquality(GameRecordDocumentEquality()).equals(
                        containerGameRecordList,
                        _model.containerPreviousSnapshot)) {
                  () async {
                    if (containerGameRecord?.teamsAcceptedResults?.length ==
                        containerGameRecord?.teamLimit) {
                      context.goNamed(
                        ResultGamePageWidget.routeName,
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
                child: StreamBuilder<List<TeamRecord>>(
                  stream: queryTeamRecord(
                    queryBuilder: (teamRecord) => teamRecord.where(
                      'game',
                      isEqualTo: containerGameRecord?.reference,
                    ),
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
                    List<TeamRecord> containerTeamRecordList = snapshot.data!;

                    return Container(
                      decoration: BoxDecoration(),
                      child: StreamBuilder<List<GameRoundRecord>>(
                        stream: queryGameRoundRecord(
                          queryBuilder: (gameRoundRecord) =>
                              gameRoundRecord.where(
                            'game',
                            isEqualTo: containerGameRecord?.reference,
                          ),
                        )..listen((snapshot) {
                            if (_model.roundsPreviousSnapshot != null &&
                                !const ListEquality(
                                        GameRoundRecordDocumentEquality())
                                    .equals(snapshot,
                                        _model.roundsPreviousSnapshot)) {
                              () async {
                                final latestRound = snapshot
                                    .sortedList(
                                        keyOf: (e) => e.createdTime!,
                                        desc: false)
                                    .lastOrNull;
                                if (latestRound?.status == 1) {
                                  context.goNamed(
                                    ProcessRoundPageWidget.routeName,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                            PageTransitionType.fade,
                                        duration: Duration(milliseconds: 0),
                                      ),
                                    },
                                  );
                                }
                                safeSetState(() {});
                              }();
                            }
                            _model.roundsPreviousSnapshot = snapshot;
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
                                          isEqualTo:
                                              containerGameRecord?.reference,
                                        )
                                        .where(
                                          'user',
                                          isEqualTo: currentUserReference,
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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<GameRoundUserRecord>
                                    containerGameRoundUserRecordList =
                                    snapshot.data!;
                                // Return an empty Container when the item does not exist.
                                if (snapshot.data!.isEmpty) {
                                  return Container();
                                }
                                final containerGameRoundUserRecord =
                                    containerGameRoundUserRecordList.isNotEmpty
                                        ? containerGameRoundUserRecordList.first
                                        : null;

                                return Container(
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              if (containerGameRecord
                                                      ?.roundsRefs?.length ==
                                                  containerGameRecord
                                                      ?.roundsLimit)
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    if (!containerGameRecord!
                                                        .teamWinner
                                                        .contains(functions
                                                            .getTeamIBelongsReference(
                                                                currentUserReference!,
                                                                containerTeamRecordList
                                                                    .toList())))
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0x1FFF453A),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      8.0,
                                                                      12.0,
                                                                      8.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Icon(
                                                                FFIcons.kskull,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                size: 20.0,
                                                              ),
                                                              Text(
                                                                'Вы проиграли',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      fontSize:
                                                                          15.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    if (containerGameRecord
                                                            ?.teamWinner
                                                            ?.contains(functions
                                                                .getTeamIBelongsReference(
                                                                    currentUserReference!,
                                                                    containerTeamRecordList
                                                                        .toList())) ??
                                                        true)
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0x2031C455),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      8.0,
                                                                      12.0,
                                                                      8.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Icon(
                                                                FFIcons
                                                                    .kconfetti,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .success,
                                                                size: 20.0,
                                                              ),
                                                              Text(
                                                                'Вы победили',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .success,
                                                                      fontSize:
                                                                          15.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              Icon(
                                                                FFIcons
                                                                    .kconfetti,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .success,
                                                                size: 20.0,
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              if (containerGameRecord!
                                                      .roundsRefs.length <
                                                  containerGameRecord!
                                                      .roundsLimit)
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    if (containerGameRoundRecordList
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .createdTime!,
                                                                desc: false)
                                                            .lastOrNull
                                                            ?.teamWinner !=
                                                        containerGameRoundUserRecord
                                                            ?.team)
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0x1FFF453A),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      8.0,
                                                                      12.0,
                                                                      8.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Icon(
                                                                FFIcons.kskull,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                size: 20.0,
                                                              ),
                                                              Text(
                                                                'Вы проиграли',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      fontSize:
                                                                          15.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    if (containerGameRoundRecordList
                                                            .sortedList(
                                                                keyOf: (e) => e
                                                                    .createdTime!,
                                                                desc: false)
                                                            .lastOrNull
                                                            ?.teamWinner ==
                                                        containerGameRoundUserRecord
                                                            ?.team)
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0x2031C455),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      8.0,
                                                                      12.0,
                                                                      8.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Icon(
                                                                FFIcons
                                                                    .kconfetti,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .success,
                                                                size: 20.0,
                                                              ),
                                                              Text(
                                                                'Вы победили',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .success,
                                                                      fontSize:
                                                                          15.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              Icon(
                                                                FFIcons
                                                                    .kconfetti,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .success,
                                                                size: 20.0,
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 8.0)),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              if (containerGameRecord!
                                                      .roundsRefs.length <
                                                  containerGameRecord!
                                                      .roundsLimit)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 0.0, 0.0),
                                                  child: Text(
                                                    '🎉 Раунд ${containerGameRecord?.roundsRefs?.length?.toString()} закончен 🎉',
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
                                                ),
                                              if (containerGameRecord
                                                      ?.roundsRefs?.length ==
                                                  containerGameRecord
                                                      ?.roundsLimit)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Подтверждение результатов',
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
                                                ),
                                              if (containerGameRecord!
                                                      .roundsRefs.length <
                                                  containerGameRecord!
                                                      .roundsLimit)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 8.0, 16.0, 0.0),
                                                  child: Text(
                                                    'Раунд закончен. Вы можете посмотреть свои результаты и статистику.',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              if (containerGameRecord
                                                      ?.roundsRefs?.length ==
                                                  containerGameRecord
                                                      ?.roundsLimit)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 8.0, 16.0, 0.0),
                                                  child: Text(
                                                    containerTeamRecordList
                                                                .where((e) =>
                                                                    e.userCaptain ==
                                                                    currentUserReference)
                                                                .toList()
                                                                .length >
                                                            0
                                                        ? 'Раунд ${containerGameRecord?.roundsRefs?.length?.toString()} завершён. Пожалуйста, подтвердите честность игры и отсутствие претензий к результатам.'
                                                        : 'Раунд ${containerGameRecord?.roundsRefs?.length?.toString()} завершён. Пожалуйста, подождите подтверждение честности игры и отсутствие претензий к результатам.',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 16.0, 0.0, 0.0),
                                                child: Text(
                                                  'Счет:',
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
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 8.0, 16.0, 0.0),
                                                child: Builder(
                                                  builder: (context) {
                                                    final teamlist =
                                                        containerTeamRecordList
                                                            .toList();

                                                    return Wrap(
                                                      spacing: 9.0,
                                                      runSpacing: 9.0,
                                                      alignment:
                                                          WrapAlignment.start,
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .start,
                                                      direction:
                                                          Axis.horizontal,
                                                      runAlignment:
                                                          WrapAlignment.start,
                                                      verticalDirection:
                                                          VerticalDirection
                                                              .down,
                                                      clipBehavior: Clip.none,
                                                      children: List.generate(
                                                          teamlist.length,
                                                          (teamlistIndex) {
                                                        final teamlistItem =
                                                            teamlist[
                                                                teamlistIndex];
                                                        return wrapWithModel(
                                                          model: _model
                                                              .teamResultItemModels
                                                              .getModel(
                                                            teamlistItem
                                                                .reference.id,
                                                            teamlistIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child:
                                                              TeamResultItemWidget(
                                                            key: Key(
                                                              'Keyz66_${teamlistItem.reference.id}',
                                                            ),
                                                            teamRef:
                                                                teamlistItem
                                                                    .reference,
                                                            count: teamlistItem
                                                                        .reference ==
                                                                    containerGameRoundRecordList
                                                                        .sortedList(
                                                                            keyOf: (e) =>
                                                                                e.createdTime!,
                                                                            desc: false)
                                                                        .lastOrNull
                                                                        ?.teamWinner
                                                                ? '1'
                                                                : '0',
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ),
                                              if ((containerGameRoundRecordList
                                                          .sortedList(
                                                              keyOf: (e) => e
                                                                  .createdTime!,
                                                              desc: false)
                                                          .lastOrNull
                                                          ?.endDateTime !=
                                                      null) &&
                                                  (containerGameRoundRecordList
                                                          .sortedList(
                                                              keyOf: (e) => e
                                                                  .createdTime!,
                                                              desc: false)
                                                          .lastOrNull
                                                          ?.startDateTime !=
                                                      null))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    2.0,
                                                                    0.0),
                                                        child: Icon(
                                                          FFIcons.ktimer,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 14.0,
                                                        ),
                                                      ),
                                                      RichText(
                                                        textScaler:
                                                            MediaQuery.of(
                                                                    context)
                                                                .textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Время раунда: ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    fontSize:
                                                                        17.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                functions.datesDifferenceEndRound(
                                                                    containerGameRoundRecordList
                                                                        .sortedList(
                                                                            keyOf: (e) => e
                                                                                .createdTime!,
                                                                            desc:
                                                                                false)
                                                                        .lastOrNull!
                                                                        .startDateTime!,
                                                                    containerGameRoundRecordList
                                                                        .sortedList(
                                                                            keyOf: (e) =>
                                                                                e.createdTime!,
                                                                            desc: false)
                                                                        .lastOrNull!
                                                                        .endDateTime!),
                                                                '00:00',
                                                              ),
                                                              style:
                                                                  TextStyle(),
                                                            )
                                                          ],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 17.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if ((containerGameRecord
                                                          ?.roundsRefs
                                                          ?.length ==
                                                      containerGameRecord
                                                          ?.roundsLimit) &&
                                                  (containerGameRecord
                                                          ?.teamsAcceptedResults
                                                          ?.length !=
                                                      containerGameRecord
                                                          ?.teamLimit) &&
                                                  (containerTeamRecordList
                                                          .where((e) =>
                                                              e.userCaptain ==
                                                              currentUserReference)
                                                          .toList()
                                                          .length ==
                                                      0))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 16.0,
                                                          16.0, 0.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .warning,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            FFIcons
                                                                .khourglasssimple,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            size: 20.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        4.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              'Последний раунд завершён. Ожидается подтверждение результатов капитанами команд.',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
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
                                                ),
                                            ]
                                                .addToStart(
                                                    SizedBox(height: 16.0))
                                                .addToEnd(
                                                    SizedBox(height: 16.0)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if (containerGameRecord!
                                                    .roundsRefs.length <
                                                containerGameRecord!
                                                    .roundsLimit)
                                              wrapWithModel(
                                                model:
                                                    _model.generalButtomModel1,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: GeneralButtomWidget(
                                                  title: 'Смотреть результаты',
                                                  isActive: true,
                                                  ignoreIsActive: false,
                                                  onTap: () async {
                                                    context.goNamed(
                                                      ResultRoundPageWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'roundRef':
                                                            serializeParam(
                                                          containerGameRoundRecordList
                                                              .sortedList(
                                                                  keyOf: (e) =>
                                                                      e.createdTime!,
                                                                  desc: false)
                                                              .lastOrNull
                                                              ?.reference,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            if ((containerGameRecord
                                                        ?.roundsRefs?.length ==
                                                    containerGameRecord
                                                        ?.roundsLimit) &&
                                                (containerTeamRecordList
                                                        .where((e) =>
                                                            e.userCaptain ==
                                                            currentUserReference)
                                                        .toList()
                                                        .length ==
                                                    0))
                                              wrapWithModel(
                                                model:
                                                    _model.generalButtomModel2,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: GeneralButtomWidget(
                                                  title: 'Результаты игры',
                                                  isActive: (containerGameRecord
                                                              ?.teamsAcceptedResults
                                                              ?.contains(functions
                                                                  .getTeamIBelongsReference(
                                                                      currentUserReference!,
                                                                      containerTeamRecordList
                                                                          .toList())) ==
                                                          true) &&
                                                      (containerGameRecord
                                                              ?.teamsAcceptedResults
                                                              ?.length ==
                                                          containerGameRecord
                                                              ?.teamLimit),
                                                  ignoreIsActive: false,
                                                  onTap: () async {
                                                    context.goNamed(
                                                        ResultGamePageWidget
                                                            .routeName);
                                                  },
                                                ),
                                              ),
                                            if ((containerGameRecord
                                                        ?.roundsRefs?.length ==
                                                    containerGameRecord
                                                        ?.roundsLimit) &&
                                                (currentUserReference ==
                                                    containerTeamRecordList
                                                        .where((e) =>
                                                            e.reference ==
                                                            functions.getMyTeamReferrence(
                                                                currentUserReference!,
                                                                containerTeamRecordList
                                                                    .toList()))
                                                        .toList()
                                                        .firstOrNull
                                                        ?.userCaptain))
                                              StreamBuilder<List<SporeRecord>>(
                                                stream: querySporeRecord(
                                                  queryBuilder: (sporeRecord) =>
                                                      sporeRecord.where(
                                                    'game',
                                                    isEqualTo:
                                                        containerGameRecord
                                                            ?.reference,
                                                  ),
                                                ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  List<SporeRecord>
                                                      containerSporeRecordList =
                                                      snapshot.data!;

                                                  return Container(
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        if ((containerSporeRecordList
                                                                    .where((e) =>
                                                                        e.user ==
                                                                        currentUserReference)
                                                                    .toList()
                                                                    .length ==
                                                                0) &&
                                                            !containerGameRecord!
                                                                .teamsAcceptedResults
                                                                .contains(functions.getTeamIBelongsReference(
                                                                    currentUserReference!,
                                                                    containerTeamRecordList
                                                                        .toList())))
                                                          wrapWithModel(
                                                            model: _model
                                                                .generalButtomModel3,
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            child:
                                                                GeneralButtomWidget(
                                                              title:
                                                                  'Подтвердить',
                                                              isActive: true,
                                                              ignoreIsActive:
                                                                  false,
                                                              onTap: () async {
                                                                await containerGameRecord!
                                                                    .reference
                                                                    .update({
                                                                  ...mapToFirestore(
                                                                    {
                                                                      'teamsAcceptedResults':
                                                                          FieldValue
                                                                              .arrayUnion([
                                                                        functions.getMyTeamReferrence(
                                                                            currentUserReference!,
                                                                            containerTeamRecordList.toList())
                                                                      ]),
                                                                    },
                                                                  ),
                                                                });
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Результаты подтверждены',
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            13.0,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            1500),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .success,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        if ((containerSporeRecordList
                                                                    .where((e) =>
                                                                        e.user ==
                                                                        currentUserReference)
                                                                    .toList()
                                                                    .length ==
                                                                0) &&
                                                            !containerGameRecord!
                                                                .teamsAcceptedResults
                                                                .contains(functions.getTeamIBelongsReference(
                                                                    currentUserReference!,
                                                                    containerTeamRecordList
                                                                        .toList())))
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                barrierColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .overlay,
                                                                enableDrag:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return WebViewAware(
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            SporAllWidget(
                                                                          gameDoc:
                                                                              containerGameRecord!,
                                                                          teamRef: containerTeamRecordList
                                                                              .where((e) => e.reference == functions.getMyTeamReferrence(currentUserReference!, containerTeamRecordList.toList()))
                                                                              .toList()
                                                                              .firstOrNull
                                                                              ?.reference,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));
                                                            },
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                                border:
                                                                    Border.all(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        12.0,
                                                                        0.0,
                                                                        12.0),
                                                                child: Text(
                                                                  'Оспорить',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            13.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        if (containerSporeRecordList
                                                                .where((e) =>
                                                                    e.user ==
                                                                    currentUserReference)
                                                                .toList()
                                                                .length >
                                                            0)
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .warning,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          16.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            8.0,
                                                                            0.0),
                                                                    child: Icon(
                                                                      FFIcons
                                                                          .kchecksquarewarning,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      'Жалоба отправлена. Ожидайте решения администратора.',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                            fontSize:
                                                                                13.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        if (containerGameRecord!
                                                                .teamsAcceptedResults
                                                                .contains(functions.getTeamIBelongsReference(
                                                                    currentUserReference!,
                                                                    containerTeamRecordList
                                                                        .toList())) &&
                                                            (containerGameRecord
                                                                    ?.teamsAcceptedResults
                                                                    ?.length !=
                                                                containerGameRecord
                                                                    ?.teamLimit))
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .success,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          16.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            8.0,
                                                                            0.0),
                                                                    child: Icon(
                                                                      FFIcons
                                                                          .kchecksquare,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      'Результаты подтверждены. Ожидается подтверждение результов другими командами.',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).alternate,
                                                                            fontSize:
                                                                                13.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        if (containerGameRecord
                                                                ?.teamsAcceptedResults
                                                                ?.length ==
                                                            containerGameRecord
                                                                ?.teamLimit)
                                                          wrapWithModel(
                                                            model: _model
                                                                .generalButtomModel4,
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            child:
                                                                GeneralButtomWidget(
                                                              title:
                                                                  'Смотреть результаты',
                                                              isActive: true,
                                                              ignoreIsActive:
                                                                  false,
                                                              onTap: () async {
                                                                context.goNamed(
                                                                    ResultGamePageWidget
                                                                        .routeName);
                                                              },
                                                            ),
                                                          ),
                                                      ].divide(SizedBox(
                                                          height: 8.0)),
                                                    ),
                                                  );
                                                },
                                              ),
                                          ].divide(SizedBox(height: 8.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
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
