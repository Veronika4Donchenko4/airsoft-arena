import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'game_status_listener_model.dart';
export 'game_status_listener_model.dart';

class GameStatusListenerWidget extends StatefulWidget {
  const GameStatusListenerWidget({super.key});

  @override
  State<GameStatusListenerWidget> createState() =>
      _GameStatusListenerWidgetState();
}

class _GameStatusListenerWidgetState extends State<GameStatusListenerWidget> {
  late GameStatusListenerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameStatusListenerModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 1000));
      _model.userActivGame = await queryGameRecordOnce(
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
      ).then((s) => s.firstOrNull);
      _model.userGameRound = await queryGameRoundRecordOnce(
        queryBuilder: (gameRoundRecord) => gameRoundRecord.where(
          'game',
          isEqualTo: _model.userActivGame?.reference,
        ),
      );
      _model.clubActivGame = await queryGameRecordOnce(
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
      _model.clubGameRound = await queryGameRoundRecordOnce(
        queryBuilder: (gameRoundRecord) => gameRoundRecord.where(
          'game',
          isEqualTo: _model.clubActivGame?.reference,
        ),
      );
      if (valueOrDefault(currentUserDocument?.type, 0) == 0) {
        if (_model.userActivGame?.reference != null) {
          if (_model.userGameRound
                  ?.sortedList(keyOf: (e) => e.createdTime!, desc: false)
                  ?.lastOrNull
                  ?.status ==
              0) {
            if (!mounted) return;
            context.goNamed(
              StartGamePageWidget.routeName,
              extra: <String, dynamic>{
                kTransitionInfoKey: TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                  duration: Duration(milliseconds: 0),
                ),
              },
            );
          } else {
            if (_model.userGameRound
                    ?.sortedList(keyOf: (e) => e.createdTime!, desc: false)
                    ?.lastOrNull
                    ?.status ==
                1) {
              if (!mounted) return;
              context.goNamed(
                ProcessRoundPageWidget.routeName,
                extra: <String, dynamic>{
                  kTransitionInfoKey: TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                  ),
                },
              );
            } else {
              if (_model.userGameRound
                      ?.sortedList(keyOf: (e) => e.createdTime!, desc: false)
                      ?.lastOrNull
                      ?.status ==
                  2) {
                if (!mounted) return;
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
              } else {
                if ((_model.userGameRound
                            ?.sortedList(
                                keyOf: (e) => e.createdTime!, desc: false)
                            ?.lastOrNull
                            ?.status ==
                        3) &&
                    ((_model.userGameRound?.length ?? 0) <
                        _model.userActivGame!.roundsLimit)) {
                  if (!mounted) return;
                  context.pushNamed(
                    ResultRoundPageWidget.routeName,
                    queryParameters: {
                      'roundRef': serializeParam(
                        _model.userGameRound
                            ?.sortedList(
                                keyOf: (e) => e.createdTime!, desc: false)
                            ?.lastOrNull
                            ?.reference,
                        ParamType.DocumentReference,
                      ),
                    },
                  );
                } else {
                  if ((_model.userGameRound
                              ?.sortedList(
                                  keyOf: (e) => e.createdTime!, desc: false)
                              ?.lastOrNull
                              ?.status ==
                          5) &&
                      ((_model.userGameRound?.length ?? 0) ==
                          (_model.userActivGame?.roundsLimit ?? 0))) {
                    if (!mounted) return;
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
                }
              }
            }
          }
        }
      } else {
        if (_model.clubActivGame?.reference != null) {
          if (_model.clubGameRound
                  ?.sortedList(keyOf: (e) => e.createdTime!, desc: false)
                  ?.lastOrNull
                  ?.status ==
              0) {
            if (!mounted) return;
            context.goNamed(
              StartGameClubPageWidget.routeName,
              extra: <String, dynamic>{
                kTransitionInfoKey: TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                  duration: Duration(milliseconds: 0),
                ),
              },
            );
          } else {
            if (_model.clubGameRound
                    ?.sortedList(keyOf: (e) => e.createdTime!, desc: false)
                    ?.lastOrNull
                    ?.status ==
                1) {
              if (!mounted) return;
              context.goNamed(
                ProcessRoundClubPageWidget.routeName,
                extra: <String, dynamic>{
                  kTransitionInfoKey: TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                  ),
                },
              );
            } else {
              if (_model.clubGameRound
                      ?.sortedList(keyOf: (e) => e.createdTime!, desc: false)
                      ?.lastOrNull
                      ?.status ==
                  2) {
                if (!mounted) return;
                context.goNamed(
                  EndRoundClubPageWidget.routeName,
                  extra: <String, dynamic>{
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              } else {
                if ((_model.clubGameRound
                            ?.sortedList(
                                keyOf: (e) => e.createdTime!, desc: false)
                            ?.lastOrNull
                            ?.status ==
                        3) &&
                    ((_model.clubGameRound?.length ?? 0) <
                        _model.clubActivGame!.roundsLimit)) {
                  if (!mounted) return;
                  context.pushNamed(ResultRoundGlubPageWidget.routeName);
                } else {
                  if ((_model.clubGameRound
                              ?.sortedList(
                                  keyOf: (e) => e.createdTime!, desc: false)
                              ?.lastOrNull
                              ?.status ==
                          5) &&
                      ((_model.clubGameRound?.length ?? 0) ==
                          (_model.clubActivGame?.roundsLimit ?? 0))) {
                    if (_model.clubActivGame?.teamsAcceptedResults?.length ==
                        _model.clubActivGame?.teamLimit) {
                      if (!mounted) return;
                      context.goNamed(
                        ResultGameGlubPageWidget.routeName,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    } else {
                      if (!mounted) return;
                      context.goNamed(
                        AccResultGameClubPageWidget.routeName,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    }
                  }
                }
              }
            }
          }
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<List<GameRecord>>(
          stream: queryGameRecord(
            queryBuilder: (gameRecord) => gameRecord
                .where(
                  'users',
                  arrayContains: currentUserReference,
                )
                .where(
                  'status',
                  isEqualTo: 2,
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
            List<GameRecord> userGameContainerGameRecordList = snapshot.data!;

            return Container(
              decoration: BoxDecoration(),
              child: StreamBuilder<List<GameRoundRecord>>(
                stream: queryGameRoundRecord(
                  queryBuilder: (gameRoundRecord) => gameRoundRecord.where(
                    'game',
                    isEqualTo:
                        userGameContainerGameRecordList.firstOrNull?.reference,
                  ),
                )..listen((snapshot) {
                    List<GameRoundRecord> containerGameRoundRecordList =
                        snapshot;
                    if (_model.containerPreviousSnapshot1 != null &&
                        !const ListEquality(GameRoundRecordDocumentEquality())
                            .equals(containerGameRoundRecordList,
                                _model.containerPreviousSnapshot1)) {
                      () async {
                        if (userGameContainerGameRecordList.firstOrNull !=
                            null) {
                          if (containerGameRoundRecordList
                                  .sortedList(
                                      keyOf: (e) => e.createdTime!, desc: false)
                                  .lastOrNull
                                  ?.status ==
                              0) {
                            if (!mounted) return;
                            context.goNamed(
                              StartPageWidget.routeName,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          } else {
                            if (containerGameRoundRecordList
                                    .sortedList(
                                        keyOf: (e) => e.createdTime!,
                                        desc: false)
                                    .lastOrNull
                                    ?.status ==
                                1) {
                              if (!mounted) return;
                              context.goNamed(
                                ProcessRoundPageWidget.routeName,
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 0),
                                  ),
                                },
                              );
                            } else {
                              if (containerGameRoundRecordList
                                      .sortedList(
                                          keyOf: (e) => e.createdTime!,
                                          desc: false)
                                      .lastOrNull
                                      ?.status ==
                                  2) {
                                if (!mounted) return;
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
                              } else {
                                if ((containerGameRoundRecordList
                                            .sortedList(
                                                keyOf: (e) => e.createdTime!,
                                                desc: false)
                                            .lastOrNull
                                            ?.status ==
                                        3) &&
                                    (containerGameRoundRecordList.length <
                                        userGameContainerGameRecordList
                                            .firstOrNull!.roundsLimit)) {
                                  if (!mounted) return;
                                  context.goNamed(
                                    ResultRoundPageWidget.routeName,
                                    queryParameters: {
                                      'roundRef': serializeParam(
                                        containerGameRoundRecordList
                                            .sortedList(
                                                keyOf: (e) => e.createdTime!,
                                                desc: false)
                                            .lastOrNull
                                            ?.reference,
                                        ParamType.DocumentReference,
                                      ),
                                    },
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 0),
                                      ),
                                    },
                                  );
                                } else {
                                  if ((containerGameRoundRecordList
                                              .sortedList(
                                                  keyOf: (e) => e.createdTime!,
                                                  desc: false)
                                              .lastOrNull
                                              ?.status ==
                                          5) &&
                                      (containerGameRoundRecordList.length ==
                                          userGameContainerGameRecordList
                                              .firstOrNull?.roundsLimit)) {
                                    if (!mounted) return;
                                    context.goNamed(
                                      ResultGamePageWidget.routeName,
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
                                }
                              }
                            }
                          }
                        }

                        safeSetState(() {});
                      }();
                    }
                    _model.containerPreviousSnapshot1 = snapshot;
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
                  );
                },
              ),
            );
          },
        ),
        StreamBuilder<List<GameRecord>>(
          stream: queryGameRecord(
            queryBuilder: (gameRecord) => gameRecord
                .where(
                  'creator',
                  isEqualTo: currentUserReference,
                )
                .where(
                  'status',
                  isEqualTo: 2,
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
            List<GameRecord> clubGameContainerGameRecordList = snapshot.data!;

            return Container(
              decoration: BoxDecoration(),
              child: StreamBuilder<List<GameRoundRecord>>(
                stream: queryGameRoundRecord(
                  queryBuilder: (gameRoundRecord) => gameRoundRecord.where(
                    'game',
                    isEqualTo:
                        clubGameContainerGameRecordList.firstOrNull?.reference,
                  ),
                )..listen((snapshot) {
                    List<GameRoundRecord> containerGameRoundRecordList =
                        snapshot;
                    if (_model.containerPreviousSnapshot2 != null &&
                        !const ListEquality(GameRoundRecordDocumentEquality())
                            .equals(containerGameRoundRecordList,
                                _model.containerPreviousSnapshot2)) {
                      () async {
                        if (clubGameContainerGameRecordList.firstOrNull !=
                            null) {
                          if (containerGameRoundRecordList
                                  .sortedList(
                                      keyOf: (e) => e.createdTime!, desc: false)
                                  .lastOrNull
                                  ?.status ==
                              0) {
                            if (!mounted) return;
                            context.goNamed(
                              StartGameClubPageWidget.routeName,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          } else {
                            if (containerGameRoundRecordList
                                    .sortedList(
                                        keyOf: (e) => e.createdTime!,
                                        desc: false)
                                    .lastOrNull
                                    ?.status ==
                                1) {
                              if (!mounted) return;
                              context.goNamed(
                                ProcessRoundClubPageWidget.routeName,
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 0),
                                  ),
                                },
                              );
                            } else {
                              if (containerGameRoundRecordList
                                      .sortedList(
                                          keyOf: (e) => e.createdTime!,
                                          desc: false)
                                      .lastOrNull
                                      ?.status ==
                                  2) {
                                if (!mounted) return;
                                context.goNamed(
                                  EndRoundClubPageWidget.routeName,
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 0),
                                    ),
                                  },
                                );
                              } else {
                                if ((containerGameRoundRecordList
                                            .sortedList(
                                                keyOf: (e) => e.createdTime!,
                                                desc: false)
                                            .lastOrNull
                                            ?.status ==
                                        3) &&
                                    (containerGameRoundRecordList.length <
                                        clubGameContainerGameRecordList
                                            .firstOrNull!.roundsLimit)) {
                                  if (!mounted) return;
                                  context.goNamed(
                                    ResultRoundGlubPageWidget.routeName,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 0),
                                      ),
                                    },
                                  );
                                } else {
                                  if ((containerGameRoundRecordList
                                              .sortedList(
                                                  keyOf: (e) => e.createdTime!,
                                                  desc: false)
                                              .lastOrNull
                                              ?.status ==
                                          5) &&
                                      (containerGameRoundRecordList.length ==
                                          clubGameContainerGameRecordList
                                              .firstOrNull?.roundsLimit)) {
                                    if (clubGameContainerGameRecordList
                                            .firstOrNull
                                            ?.teamsAcceptedResults
                                            ?.length ==
                                        clubGameContainerGameRecordList
                                            .firstOrNull?.teamLimit) {
                                      if (!mounted) return;
                                      context.goNamed(
                                        ResultGameGlubPageWidget.routeName,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                            duration: Duration(milliseconds: 0),
                                          ),
                                        },
                                      );
                                    } else {
                                      if (!mounted) return;
                                      context.goNamed(
                                        AccResultGameClubPageWidget.routeName,
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
                                  }
                                }
                              }
                            }
                          }
                        }

                        safeSetState(() {});
                      }();
                    }
                    _model.containerPreviousSnapshot2 = snapshot;
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
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
