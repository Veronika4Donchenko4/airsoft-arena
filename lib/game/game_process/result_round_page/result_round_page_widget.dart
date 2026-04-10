import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/switch_item/switch_item_widget.dart';
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
import 'result_round_page_model.dart';
export 'result_round_page_model.dart';

class ResultRoundPageWidget extends StatefulWidget {
  const ResultRoundPageWidget({
    super.key,
    this.roundRef,
  });

  final DocumentReference? roundRef;

  static String routeName = 'ResultRoundPage';
  static String routePath = '/resultRoundPage';

  @override
  State<ResultRoundPageWidget> createState() => _ResultRoundPageWidgetState();
}

class _ResultRoundPageWidgetState extends State<ResultRoundPageWidget> {
  late ResultRoundPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResultRoundPageModel());

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
                                if (latestRound != null &&
                                    (latestRound.status == 0 ||
                                        latestRound.status == 1)) {
                                  if (!mounted) return;
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

                          final _sortedRounds = containerGameRoundRecordList
                              .sortedList(
                                  keyOf: (e) => e.createdTime!, desc: false);
                          final currentRound = widget.roundRef != null
                              ? (_sortedRounds
                                      .where((r) =>
                                          r.reference == widget.roundRef)
                                      .firstOrNull ??
                                  _sortedRounds.lastOrNull)
                              : _sortedRounds.lastOrNull;
                          final currentRoundNumber = currentRound != null
                              ? _sortedRounds.indexWhere(
                                      (r) =>
                                          r.reference ==
                                          currentRound.reference) +
                                  1
                              : 0;

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
                                          'roundReference',
                                          isEqualTo: currentRound?.reference,
                                        )
                                        .where(
                                          'user',
                                          isEqualTo: currentUserReference,
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
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 16.0, 0.0, 0.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Результаты раунда',
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
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      if (currentRound
                                                              ?.teamWinner !=
                                                          containerGameRoundUserRecord
                                                              ?.team)
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x1FFF453A),
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
                                                                      .kskull,
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
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        fontSize:
                                                                            15.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 8.0)),
                                                            ),
                                                          ),
                                                        ),
                                                      if (currentRound
                                                              ?.teamWinner ==
                                                          containerGameRoundUserRecord
                                                              ?.team)
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x2031C455),
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
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .success,
                                                                        fontSize:
                                                                            15.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                ),
                                                if (currentRound?.endDateTime !=
                                                        null &&
                                                    currentRound
                                                            ?.startDateTime !=
                                                        null)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 8.0,
                                                                0.0, 0.0),
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
                                                            size: 12.0,
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
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
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
                                                                      currentRound!
                                                                          .startDateTime!,
                                                                      currentRound!
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
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
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
                                                                    4.0,
                                                                    0.0),
                                                        child: Icon(
                                                          FFIcons.khandFist,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 18.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        valueOrDefault<String>(
                                                          containerGameRecord
                                                              ?.name,
                                                          'Game',
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                              fontSize: 17.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent2,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(9.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        4.0,
                                                                        0.0),
                                                            child: Icon(
                                                              FFIcons.kgun2,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 14.0,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Раунд $currentRoundNumber из ${containerGameRecord?.roundsLimit?.toString()}',
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 0.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final allTeam =
                                                          containerTeamRecordList
                                                              .toList();

                                                      return SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: List.generate(
                                                                  allTeam
                                                                      .length,
                                                                  (allTeamIndex) {
                                                            final allTeamItem =
                                                                allTeam[
                                                                    allTeamIndex];
                                                            return InkWell(
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
                                                                _model.teamSelected =
                                                                    allTeamItem
                                                                        .reference;
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child:
                                                                  wrapWithModel(
                                                                model: _model
                                                                    .switchItemModels
                                                                    .getModel(
                                                                  allTeamItem
                                                                      .reference
                                                                      .id,
                                                                  allTeamIndex,
                                                                ),
                                                                updateCallback: () =>
                                                                    safeSetState(
                                                                        () {}),
                                                                child:
                                                                    SwitchItemWidget(
                                                                  key: Key(
                                                                    'Key3j0_${allTeamItem.reference.id}',
                                                                  ),
                                                                  isActiv: allTeamItem
                                                                          .reference ==
                                                                      _model
                                                                          .teamSelected,
                                                                  teamRef:
                                                                      allTeamItem
                                                                          .reference,
                                                                ),
                                                              ),
                                                            );
                                                          })
                                                              .addToStart(
                                                                  SizedBox(
                                                                      width:
                                                                          16.0))
                                                              .addToEnd(SizedBox(
                                                                  width: 16.0)),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                if (_model.teamSelected != null)
                                                  StreamBuilder<TeamRecord>(
                                                    stream:
                                                        TeamRecord.getDocument(
                                                            _model
                                                                .teamSelected!),
                                                    builder:
                                                        (context, snapshot) {
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

                                                      final containerTeamRecord =
                                                          snapshot.data!;

                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                24.0,
                                                                            height:
                                                                                24.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: containerTeamRecord.color,
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(4.0),
                                                                              child: Icon(
                                                                                FFIcons.kusersfour,
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                size: 16.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              containerTeamRecord.name,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    fontSize: 15.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .accent1,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Builder(
                                                                builder:
                                                                    (context) {
                                                                  final userList =
                                                                      containerTeamRecord
                                                                          .usersJob
                                                                          .toList();

                                                                  return ListView
                                                                      .builder(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    primary:
                                                                        false,
                                                                    shrinkWrap:
                                                                        true,
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    itemCount:
                                                                        userList
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            userListIndex) {
                                                                      final userListItem =
                                                                          userList[
                                                                              userListIndex];
                                                                      return StreamBuilder<
                                                                          List<
                                                                              GameRoundUserRecord>>(
                                                                        stream:
                                                                            queryGameRoundUserRecord(
                                                                          queryBuilder: (gameRoundUserRecord) => gameRoundUserRecord
                                                                              .where(
                                                                                'game',
                                                                                isEqualTo: containerGameRecord?.reference,
                                                                              )
                                                                              .where(
                                                                                'roundReference',
                                                                                isEqualTo: currentRound?.reference,
                                                                              ),
                                                                        ),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
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
                                                                              containerGameRoundUserRecordList =
                                                                              snapshot.data!;

                                                                          return Container(
                                                                            width:
                                                                                double.infinity,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    StreamBuilder<UserRecord>(
                                                                                      stream: UserRecord.getDocument(userListItem.user!),
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

                                                                                        final containerUserRecord = snapshot.data!;

                                                                                        return Container(
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                                                                                            child: Row(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                                  child: Text(
                                                                                                    functions.intIncrement(userListIndex).toString(),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.inter(
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                          fontSize: 12.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 32.0,
                                                                                                    height: 32.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).accent1,
                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                    ),
                                                                                                    child: Stack(
                                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                      children: [
                                                                                                        Icon(
                                                                                                          FFIcons.kuser,
                                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                          size: 18.0,
                                                                                                        ),
                                                                                                        if (containerUserRecord.photoUrl != null && containerUserRecord.photoUrl != '')
                                                                                                          Container(
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).accent1,
                                                                                                              borderRadius: BorderRadius.circular(12.0),
                                                                                                            ),
                                                                                                            child: ClipRRect(
                                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                                              child: Image.network(
                                                                                                                containerUserRecord.photoUrl,
                                                                                                                width: double.infinity,
                                                                                                                height: double.infinity,
                                                                                                                fit: BoxFit.cover,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        containerUserRecord.displayName,
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: 13.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                      StreamBuilder<JobRecord>(
                                                                                                        stream: JobRecord.getDocument(userListItem.job!),
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

                                                                                                          final textJobRecord = snapshot.data!;

                                                                                                          return Text(
                                                                                                            textJobRecord.name,
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                  fontSize: 11.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          );
                                                                                                        },
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                    Container(
                                                                                      decoration: BoxDecoration(),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        children: [
                                                                                          Icon(
                                                                                            FFIcons.ksmileyxeyes,
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            size: 14.0,
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              valueOrDefault<String>(
                                                                                                containerGameRoundUserRecordList.where((e) => e.user == userListItem.user).toList().firstOrNull?.kills?.toString(),
                                                                                                '0',
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    fontSize: 13.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                            child: Icon(
                                                                                              FFIcons.kskull,
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              size: 14.0,
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              containerGameRoundUserRecordList.where((e) => e.user == userListItem.user).toList().firstOrNull!.isDead ? '1' : '0',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    fontSize: 13.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                            child: Container(
                                                                                              decoration: BoxDecoration(
                                                                                                color: FlutterFlowTheme.of(context).accent2,
                                                                                                borderRadius: BorderRadius.circular(9.0),
                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 7.0, 8.0, 7.0),
                                                                                                child: Row(
                                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                                  children: [
                                                                                                    Icon(
                                                                                                      FFIcons.kmedal,
                                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                                      size: 12.0,
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          containerGameRoundUserRecordList.where((e) => e.user == userListItem.user).toList().firstOrNull?.rating?.toString(),
                                                                                                          '0',
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: 13.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Container(
                                                                                  width: double.infinity,
                                                                                  height: 1.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).accent1,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 8.0),
                                            child: wrapWithModel(
                                              model: _model.generalButtomModel,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: GeneralButtomWidget(
                                                title: 'Следующий раунд',
                                                isActive: true,
                                                ignoreIsActive: false,
                                                onTap: () async {
                                                  if (!mounted) return;
                                                  context.goNamed(
                                                      StartGamePageWidget
                                                          .routeName);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
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
