import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'router_page_model.dart';
export 'router_page_model.dart';

class RouterPageWidget extends StatefulWidget {
  const RouterPageWidget({super.key});

  static String routeName = 'RouterPage';
  static String routePath = '/routerPage';

  @override
  State<RouterPageWidget> createState() => _RouterPageWidgetState();
}

class _RouterPageWidgetState extends State<RouterPageWidget> {
  late RouterPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RouterPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 1000));
      if (FFAppState().onboardingShown) {
        if (loggedIn) {
          unawaited(
            () async {
              await actions.saveCurrentUserPosition();
            }(),
          );
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
          if (currentUserDocument?.city?.placeId != null &&
              currentUserDocument?.city?.placeId != '') {
            if (valueOrDefault(currentUserDocument?.type, 0) == 0) {
              if (_model.userActivGame?.reference != null) {
                if (_model.userGameRound
                        ?.sortedList(keyOf: (e) => e.createdTime!, desc: false)
                        ?.lastOrNull
                        ?.status ==
                    0) {
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
                          ?.sortedList(
                              keyOf: (e) => e.createdTime!, desc: false)
                          ?.lastOrNull
                          ?.status ==
                      1) {
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
                            ?.sortedList(
                                keyOf: (e) => e.createdTime!, desc: false)
                            ?.lastOrNull
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
                    } else {
                      if ((_model.userGameRound
                                  ?.sortedList(
                                      keyOf: (e) => e.createdTime!, desc: false)
                                  ?.lastOrNull
                                  ?.status ==
                              3) &&
                          (_model.userActivGame!.roundsRefs.length <
                              _model.userActivGame!.roundsLimit)) {
                        context.pushNamed(
                          ResultRoundPageWidget.routeName,
                          queryParameters: {
                            'roundRef': serializeParam(
                              _model.userGameRound
                                  ?.sortedList(
                                      keyOf: (e) => e.createdTime!,
                                      desc: false)
                                  ?.lastOrNull
                                  ?.reference,
                              ParamType.DocumentReference,
                            ),
                          },
                        );
                      } else {
                        if ((_model.userGameRound
                                    ?.sortedList(
                                        keyOf: (e) => e.createdTime!,
                                        desc: false)
                                    ?.lastOrNull
                                    ?.status ==
                                5) &&
                            (_model.userActivGame?.roundsRefs?.length ==
                                _model.userActivGame?.roundsLimit)) {
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
              } else {
                context.goNamed(
                  GamesPageWidget.routeName,
                  extra: <String, dynamic>{
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              }
            } else {
              if (_model.clubActivGame?.reference != null) {
                if (_model.clubGameRound
                        ?.sortedList(keyOf: (e) => e.createdTime!, desc: false)
                        ?.lastOrNull
                        ?.status ==
                    0) {
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
                          ?.sortedList(
                              keyOf: (e) => e.createdTime!, desc: false)
                          ?.lastOrNull
                          ?.status ==
                      1) {
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
                            ?.sortedList(
                                keyOf: (e) => e.createdTime!, desc: false)
                            ?.lastOrNull
                            ?.status ==
                        2) {
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
                          (_model.clubActivGame!.roundsRefs.length <
                              _model.clubActivGame!.roundsLimit)) {
                        context.pushNamed(ResultRoundGlubPageWidget.routeName);
                      } else {
                        if ((_model.clubGameRound
                                    ?.sortedList(
                                        keyOf: (e) => e.createdTime!,
                                        desc: false)
                                    ?.lastOrNull
                                    ?.status ==
                                5) &&
                            (_model.clubActivGame?.roundsRefs?.length ==
                                _model.clubActivGame?.roundsLimit)) {
                          if (_model.clubActivGame?.teamsAcceptedResults
                                  ?.length ==
                              _model.clubActivGame?.teamLimit) {
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
              } else {
                context.goNamed(
                  GamesClubPageWidget.routeName,
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
          } else {
            context.goNamed(
              CreateProfileWidget.routeName,
              extra: <String, dynamic>{
                kTransitionInfoKey: TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                  duration: Duration(milliseconds: 0),
                ),
              },
            );
          }
        } else {
          context.goNamed(
            LoginPageWidget.routeName,
            extra: <String, dynamic>{
              kTransitionInfoKey: TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
                duration: Duration(milliseconds: 0),
              ),
            },
          );
        }
      } else {
        context.goNamed(
          OnboardingPageWidget.routeName,
          extra: <String, dynamic>{
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
      }
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
    context.watch<FFAppState>();

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
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  child: custom_widgets.LoadingIndicator(
                    width: 40.0,
                    height: 40.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
