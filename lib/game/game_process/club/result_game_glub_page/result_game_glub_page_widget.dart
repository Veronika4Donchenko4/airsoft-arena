import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/components/switch_item/switch_item_widget.dart';
import '/components/team_result_item/team_result_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'result_game_glub_page_model.dart';
export 'result_game_glub_page_model.dart';

class ResultGameGlubPageWidget extends StatefulWidget {
  const ResultGameGlubPageWidget({super.key});

  static String routeName = 'ResultGameGlubPage';
  static String routePath = '/resultGameGlubPage';

  @override
  State<ResultGameGlubPageWidget> createState() =>
      _ResultGameGlubPageWidgetState();
}

class _ResultGameGlubPageWidgetState extends State<ResultGameGlubPageWidget> {
  late ResultGameGlubPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResultGameGlubPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.gameLoaded = await queryGameRecordOnce(
        queryBuilder: (gameRecord) => gameRecord
            .where(
              'status',
              isEqualTo: 2,
            )
            .where(
              'creator',
              isEqualTo: currentUserReference,
            ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      _model.userLoaded = await actions.getUserFromRefList(
        _model.gameLoaded!.users.toList(),
      );
    });

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
                    'creator',
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
                          List<GameRoundRecord> containerGameRoundRecordList =
                              snapshot.data!;

                          return Container(
                            decoration: BoxDecoration(),
                            child: StreamBuilder<List<GameUserRecord>>(
                              stream: queryGameUserRecord(
                                queryBuilder: (gameUserRecord) =>
                                    gameUserRecord.where(
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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<GameUserRecord>
                                    containerGameUserRecordList =
                                    snapshot.data!;

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
                                                  'Результаты игры',
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
                                                          'Игра',
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                              fontSize: 15.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                                          0.0, 8.0, 0.0, 0.0),
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
                                                                  'Общее время игры: ',
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
                                                                        .firstOrNull!
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
                                                                fontSize: 13.0,
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
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        containerGameRecord
                                                                    ?.teamWinner
                                                                    ?.length ==
                                                                1
                                                            ? 'Победила команда:'
                                                            : 'Победили команды:',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
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
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    16.0),
                                                        child: Builder(
                                                          builder: (context) {
                                                            final teamWinners =
                                                                containerGameRecord
                                                                        ?.teamWinner
                                                                        ?.toList() ??
                                                                    [];

                                                            return Wrap(
                                                              spacing: 4.0,
                                                              runSpacing: 4.0,
                                                              alignment:
                                                                  WrapAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  WrapCrossAlignment
                                                                      .start,
                                                              direction: Axis
                                                                  .horizontal,
                                                              runAlignment:
                                                                  WrapAlignment
                                                                      .start,
                                                              verticalDirection:
                                                                  VerticalDirection
                                                                      .down,
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: List.generate(
                                                                  teamWinners
                                                                      .length,
                                                                  (teamWinnersIndex) {
                                                                final teamWinnersItem =
                                                                    teamWinners[
                                                                        teamWinnersIndex];
                                                                return StreamBuilder<
                                                                    TeamRecord>(
                                                                  stream: TeamRecord
                                                                      .getDocument(
                                                                          teamWinnersItem),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              30.0,
                                                                          height:
                                                                              30.0,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            valueColor:
                                                                                AlwaysStoppedAnimation<Color>(
                                                                              FlutterFlowTheme.of(context).primary,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }

                                                                    final containerTeamRecord =
                                                                        snapshot
                                                                            .data!;

                                                                    return Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .success,
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            24.0,
                                                                            12.0,
                                                                            24.0,
                                                                            12.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children:
                                                                              [
                                                                            Icon(
                                                                              FFIcons.kconfetti,
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                            Text(
                                                                              containerTeamRecord.name,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 17.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            Icon(
                                                                              FFIcons.kconfetti,
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                          ].divide(SizedBox(width: 8.0)),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              }),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Счет игры:',
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
                                                          fontSize: 13.0,
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
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final teamCountList =
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
                                                            teamCountList
                                                                .length,
                                                            (teamCountListIndex) {
                                                          final teamCountListItem =
                                                              teamCountList[
                                                                  teamCountListIndex];
                                                          return wrapWithModel(
                                                            model: _model
                                                                .teamResultItemModels
                                                                .getModel(
                                                              teamCountListItem
                                                                  .reference.id,
                                                              teamCountListIndex,
                                                            ),
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            child:
                                                                TeamResultItemWidget(
                                                              key: Key(
                                                                'Keyogl_${teamCountListItem.reference.id}',
                                                              ),
                                                              count: functions
                                                                  .getTeamGameTotalWins(
                                                                      teamCountListItem
                                                                          .reference,
                                                                      containerGameRoundRecordList
                                                                          .toList())
                                                                  .toString(),
                                                              teamRef:
                                                                  teamCountListItem
                                                                      .reference,
                                                            ),
                                                          );
                                                        }),
                                                      );
                                                    },
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
                                                                    'Keyfoo_${allTeamItem.reference.id}',
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
                                                  Container(
                                                    decoration: BoxDecoration(),
                                                    child: StreamBuilder<
                                                        TeamRecord>(
                                                      stream: TeamRecord
                                                          .getDocument(_model
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
                                                                              width: 24.0,
                                                                              height: 24.0,
                                                                              decoration: BoxDecoration(
                                                                                color: containerTeamRecord.color,
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(4.0),
                                                                                child: Icon(
                                                                                  FFIcons.kusersfour,
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  size: 16.0,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                              child: Text(
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
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent1,
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
                                                                            userList[userListIndex];
                                                                        return Container(
                                                                          width:
                                                                              double.infinity,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
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
                                                                                              containerGameUserRecordList.where((e) => e.user == userListItem.user).toList().firstOrNull?.kills?.toString(),
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
                                                                                            valueOrDefault<String>(
                                                                                              containerGameUserRecordList.where((e) => e.user == userListItem.user).toList().firstOrNull?.deth?.toString(),
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
                                                                                                        containerGameUserRecordList.where((e) => e.user == userListItem.user).toList().firstOrNull?.rating?.toString(),
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
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                              ].addToEnd(
                                                  SizedBox(height: 16.0)),
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
                                                title: 'Выйти на главную',
                                                isActive: true,
                                                ignoreIsActive: false,
                                                onTap: () async {
                                                  _model.achivList =
                                                      await queryAchievementRecordOnce();
                                                  final allRoundUsers =
                                                      await queryGameRoundUserRecordOnce(
                                                    queryBuilder: (q) =>
                                                        q.where('game',
                                                            isEqualTo:
                                                                containerGameRecord
                                                                    ?.reference),
                                                  );
                                                  while (_model.userCounter <
                                                      containerGameRecord!
                                                          .users.length) {
                                                    final currentUserRef =
                                                        containerGameRecord!
                                                            .users
                                                            .elementAtOrNull(
                                                                _model
                                                                    .userCounter)!;
                                                    final didAttend =
                                                        allRoundUsers.any((r) =>
                                                            r.user ==
                                                                currentUserRef &&
                                                            r.attended);
                                                    final baseRate = functions
                                                        .calculateUserTotalRating(
                                                            _model.userLoaded
                                                                ?.elementAtOrNull(
                                                                    _model
                                                                        .userCounter)
                                                                ?.rate,
                                                            containerGameUserRecordList
                                                                .elementAtOrNull(
                                                                    _model
                                                                        .userCounter)!
                                                                .rating);
                                                    final finalRate = didAttend
                                                        ? baseRate
                                                        : ((baseRate ?? 0.0) -
                                                                1.0)
                                                            .clamp(0.0,
                                                                double.infinity);
                                                    await _model.userLoaded!
                                                        .elementAtOrNull(
                                                            _model.userCounter)!
                                                        .reference
                                                        .update({
                                                      ...createUserRecordData(
                                                        rate: finalRate,
                                                        kilss: functions.totalKillsDeath(
                                                            _model.userLoaded
                                                                ?.elementAtOrNull(
                                                                    _model
                                                                        .userCounter)
                                                                ?.kilss,
                                                            containerGameUserRecordList
                                                                .elementAtOrNull(
                                                                    _model
                                                                        .userCounter)!
                                                                .kills),
                                                        deth: functions.totalKillsDeath(
                                                            _model.userLoaded
                                                                ?.elementAtOrNull(
                                                                    _model
                                                                        .userCounter)
                                                                ?.deth,
                                                            containerGameUserRecordList
                                                                .elementAtOrNull(
                                                                    _model
                                                                        .userCounter)!
                                                                .deth),
                                                        win: functions.totalWiner(
                                                            _model.userLoaded
                                                                ?.elementAtOrNull(
                                                                    _model
                                                                        .userCounter)
                                                                ?.win,
                                                            containerGameRecord!
                                                                .teamWinner
                                                                .toList(),
                                                            functions.getTeamIBelongsReference(
                                                                _model
                                                                    .userLoaded!
                                                                    .elementAtOrNull(
                                                                        _model
                                                                            .userCounter)!
                                                                    .reference,
                                                                containerTeamRecordList
                                                                    .toList()) ?? FirebaseFirestore.instance.doc('teams/none')),
                                                        losses: functions.totalLoses(
                                                            _model.userLoaded
                                                                ?.elementAtOrNull(
                                                                    _model
                                                                        .userCounter)
                                                                ?.losses,
                                                            containerGameRecord!
                                                                .teamWinner
                                                                .toList(),
                                                            functions.getTeamIBelongsReference(
                                                                _model
                                                                    .userLoaded!
                                                                    .elementAtOrNull(
                                                                        _model
                                                                            .userCounter)
                                                                    ?.reference ?? FirebaseFirestore.instance.doc('users/none'),
                                                                containerTeamRecordList
                                                                    .toList()) ?? FirebaseFirestore.instance.doc('teams/none')),
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'gameCount':
                                                              FieldValue
                                                                  .increment(1),
                                                          'seriesNoLosess':
                                                              FieldValue
                                                                  .arrayUnion([
                                                            containerGameRecord?.teamWinner?.contains(functions.getTeamIBelongsReference(
                                                                        containerGameRecord!
                                                                            .users
                                                                            .elementAtOrNull(_model
                                                                                .userCounter)!,
                                                                        containerTeamRecordList
                                                                            .toList())) ==
                                                                    true
                                                                ? true
                                                                : false
                                                          ]),
                                                        },
                                                      ),
                                                    });
                                                    await actions
                                                        .setUserMaxKills(
                                                      containerGameRecord!.users
                                                          .elementAtOrNull(_model
                                                              .userCounter)!,
                                                      containerGameUserRecordList
                                                          .where((e) =>
                                                              e.user ==
                                                              (containerGameRecord
                                                                  ?.users
                                                                  ?.elementAtOrNull(
                                                                      _model
                                                                          .userCounter)))
                                                          .toList()
                                                          .firstOrNull!
                                                          .kills,
                                                    );
                                                    await actions
                                                        .checkUserAchivements(
                                                      containerGameRecord!.users
                                                          .elementAtOrNull(_model
                                                              .userCounter)!,
                                                      _model.achivList!
                                                          .toList(),
                                                    );
                                                    _model.userCounter =
                                                        _model.userCounter + 1;
                                                  }
                                                  await Future.delayed(
                                                      const Duration(
                                                          milliseconds: 1000));

                                                  context.goNamed(
                                                    GamesClubPageWidget
                                                        .routeName,
                                                    extra: <String, dynamic>{
                                                      kTransitionInfoKey:
                                                          TransitionInfo(
                                                        hasTransition: true,
                                                        transitionType:
                                                            PageTransitionType
                                                                .fade,
                                                        duration: Duration(
                                                            milliseconds: 0),
                                                      ),
                                                    },
                                                  );

                                                  await containerGameRecord!
                                                      .reference
                                                      .update(
                                                          createGameRecordData(
                                                    status: 1,
                                                  ));

                                                  await containerGameRoundRecordList
                                                      .sortedList(
                                                          keyOf: (e) =>
                                                              e.createdTime!,
                                                          desc: false)
                                                      .lastOrNull!
                                                      .reference
                                                      .update(
                                                          createGameRoundRecordData(
                                                        status: 4,
                                                      ));

                                                  safeSetState(() {});
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
