import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/general_buttom/general_buttom_widget.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'end_round_club_page_model.dart';
export 'end_round_club_page_model.dart';

class EndRoundClubPageWidget extends StatefulWidget {
  const EndRoundClubPageWidget({super.key});

  static String routeName = 'EndRoundClubPage';
  static String routePath = '/endRoundClubPage';

  @override
  State<EndRoundClubPageWidget> createState() => _EndRoundClubPageWidgetState();
}

class _EndRoundClubPageWidgetState extends State<EndRoundClubPageWidget> {
  late EndRoundClubPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EndRoundClubPageModel());

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
                            child: StreamBuilder<List<GameRoundUserRecord>>(
                              stream: queryGameRoundUserRecord(
                                queryBuilder: (gameRoundUserRecord) =>
                                    gameRoundUserRecord.where(
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
                                List<GameRoundUserRecord>
                                    containerGameRoundUserRecordList =
                                    snapshot.data!;

                                return Container(
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 8.0, 16.0, 0.0),
                                                child: Text(
                                                  containerGameRecord
                                                              ?.roundsRefs
                                                              ?.length ==
                                                          containerGameRecord
                                                              ?.roundsLimit
                                                      ? 'Все раунды закончены. Просмотрите результаты игры.'
                                                      : 'Раунд успешно закончен. Вы можете просмотреть результаты команд и игроков.',
                                                  textAlign: TextAlign.center,
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
                                                              'Key7xq_${teamlistItem.reference.id}',
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
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 16.0, 0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 14.0,
                                                      ),
                                                    ),
                                                    RichText(
                                                      textScaler:
                                                          MediaQuery.of(context)
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
                                                                          keyOf: (e) => e
                                                                              .createdTime!,
                                                                          desc:
                                                                              false)
                                                                      .lastOrNull!
                                                                      .endDateTime!),
                                                              '00:00',
                                                            ),
                                                            style: TextStyle(),
                                                          )
                                                        ],
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
                                                              fontSize: 17.0,
                                                              letterSpacing:
                                                                  0.0,
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
                                                  ],
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
                                                    await containerGameRoundRecordList
                                                        .sortedList(
                                                            keyOf: (e) =>
                                                                e.createdTime!,
                                                            desc: false)
                                                        .lastOrNull!
                                                        .reference
                                                        .update(
                                                            createGameRoundRecordData(
                                                          status: 3,
                                                        ));

                                                    context.goNamed(
                                                        ResultRoundGlubPageWidget
                                                            .routeName);
                                                  },
                                                ),
                                              ),
                                            if ((containerGameRecord
                                                        ?.roundsRefs?.length ==
                                                    containerGameRecord
                                                        ?.roundsLimit) &&
                                                (currentUserReference ==
                                                    containerGameRecord
                                                        ?.creator))
                                              wrapWithModel(
                                                model:
                                                    _model.generalButtomModel2,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: GeneralButtomWidget(
                                                  title:
                                                      'Перейти к окончанию игры',
                                                  isActive: true,
                                                  ignoreIsActive: false,
                                                  onTap: () async {
                                                    while (
                                                        _model.userSaveCounter <
                                                            containerGameRecord!
                                                                .users.length) {
                                                      var gameUserRecordReference =
                                                          GameUserRecord
                                                              .collection
                                                              .doc();
                                                      await gameUserRecordReference
                                                          .set(
                                                              createGameUserRecordData(
                                                        game:
                                                            containerGameRecord
                                                                ?.reference,
                                                        user: containerGameRecord
                                                            ?.users
                                                            ?.elementAtOrNull(_model
                                                                .userSaveCounter),
                                                        kills: functions.calculateGameUserKills(
                                                            containerGameRoundUserRecordList
                                                                .where((e) =>
                                                                    e.user ==
                                                                    (containerGameRecord
                                                                        ?.users
                                                                        ?.elementAtOrNull(
                                                                            _model.userSaveCounter)))
                                                                .toList()),
                                                        rating: functions.calculateGameUserRating(
                                                            containerGameRoundUserRecordList
                                                                .where((e) =>
                                                                    e.user ==
                                                                    (containerGameRecord
                                                                        ?.users
                                                                        ?.elementAtOrNull(
                                                                            _model.userSaveCounter)))
                                                                .toList()),
                                                        team: functions.getTeamIBelongsReference(
                                                            containerGameRecord!
                                                                .users
                                                                .elementAtOrNull(
                                                                    _model
                                                                        .userSaveCounter)!,
                                                            containerTeamRecordList
                                                                .toList()),
                                                        deth: functions.calculateGameUserDeaths(
                                                            containerGameRoundUserRecordList
                                                                .where((e) =>
                                                                    e.user ==
                                                                    (containerGameRecord
                                                                        ?.users
                                                                        ?.elementAtOrNull(
                                                                            _model.userSaveCounter)))
                                                                .toList()),
                                                      ));
                                                      _model.gameUserSaved =
                                                          GameUserRecord
                                                              .getDocumentFromData(
                                                                  createGameUserRecordData(
                                                                    game: containerGameRecord
                                                                        ?.reference,
                                                                    user: containerGameRecord
                                                                        ?.users
                                                                        ?.elementAtOrNull(
                                                                            _model.userSaveCounter),
                                                                    kills: functions.calculateGameUserKills(containerGameRoundUserRecordList
                                                                        .where((e) =>
                                                                            e.user ==
                                                                            (containerGameRecord?.users?.elementAtOrNull(_model.userSaveCounter)))
                                                                        .toList()),
                                                                    rating: functions.calculateGameUserRating(containerGameRoundUserRecordList
                                                                        .where((e) =>
                                                                            e.user ==
                                                                            (containerGameRecord?.users?.elementAtOrNull(_model.userSaveCounter)))
                                                                        .toList()),
                                                                    team: functions.getTeamIBelongsReference(
                                                                        containerGameRecord!
                                                                            .users
                                                                            .elementAtOrNull(_model
                                                                                .userSaveCounter)!,
                                                                        containerTeamRecordList
                                                                            .toList()),
                                                                    deth: functions.calculateGameUserDeaths(containerGameRoundUserRecordList
                                                                        .where((e) =>
                                                                            e.user ==
                                                                            (containerGameRecord?.users?.elementAtOrNull(_model.userSaveCounter)))
                                                                        .toList()),
                                                                  ),
                                                                  gameUserRecordReference);
                                                      _model
                                                          .addToSaveGameUserList(
                                                              _model
                                                                  .gameUserSaved!
                                                                  .reference);
                                                      _model.userSaveCounter =
                                                          _model.userSaveCounter +
                                                              1;
                                                    }
                                                    _model.gameTeamsWinners =
                                                        await actions
                                                            .calculateGameWinners(
                                                      containerGameRoundRecordList
                                                          .toList(),
                                                    );

                                                    await containerGameRecord!
                                                        .reference
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'gameUsers': _model
                                                              .saveGameUserList,
                                                          'teamWinner': _model
                                                              .gameTeamsWinners,
                                                        },
                                                      ),
                                                    });

                                                    await containerGameRoundRecordList
                                                        .sortedList(
                                                            keyOf: (e) =>
                                                                e.createdTime!,
                                                            desc: false)
                                                        .lastOrNull!
                                                        .reference
                                                        .update(
                                                            createGameRoundRecordData(
                                                          status: 5,
                                                        ));
                                                    _model.gameRoundUserLoaded =
                                                        await queryGameRoundUserRecordOnce(
                                                      queryBuilder:
                                                          (gameRoundUserRecord) =>
                                                              gameRoundUserRecord
                                                                  .where(
                                                        'game',
                                                        isEqualTo:
                                                            containerGameRecord
                                                                ?.reference,
                                                      ),
                                                    );
                                                    await actions
                                                        .setGameResults(
                                                      _model
                                                          .gameRoundUserLoaded!
                                                          .toList(),
                                                    );

                                                    context.goNamed(
                                                        AccResultGameClubPageWidget
                                                            .routeName);

                                                    safeSetState(() {});
                                                  },
                                                ),
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
