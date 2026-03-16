import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/app_bar/app_bar_widget.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_games_page_model.dart';
export 'my_games_page_model.dart';

class MyGamesPageWidget extends StatefulWidget {
  const MyGamesPageWidget({super.key});

  static String routeName = 'MyGamesPage';
  static String routePath = '/myGamesPage';

  @override
  State<MyGamesPageWidget> createState() => _MyGamesPageWidgetState();
}

class _MyGamesPageWidgetState extends State<MyGamesPageWidget> {
  late MyGamesPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyGamesPageModel());

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
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  wrapWithModel(
                    model: _model.appBarModel,
                    updateCallback: () => safeSetState(() {}),
                    child: AppBarWidget(
                      title: 'Мои игры',
                      withoutDots: true,
                      action: () async {},
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      StreamBuilder<List<GameRecord>>(
                        stream: queryGameRecord(
                          queryBuilder: (gameRecord) => gameRecord
                              .where(
                                'users',
                                arrayContains: currentUserReference,
                              )
                              .orderBy('dateTime', descending: true),
                          limit: 10,
                        ),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.waiting) {
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

                          final games = snapshot.data ?? [];

                          if (games.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 64.0),
                              child: Center(
                                child: Text(
                                  'Вы еще не участвовали в играх',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            );
                          }

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: games.map((game) {
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 8.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).accent2,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          game.name,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          game.dateTime != null
                                              ? DateFormat('d MMMM y HH:mm',
                                                      'ru')
                                                  .format(game.dateTime!)
                                              : '',
                                          style: FlutterFlowTheme.of(context)
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
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 13.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        SizedBox(height: 8.0),
                                        StreamBuilder<List<TeamRecord>>(
                                          stream: queryTeamRecord(
                                            queryBuilder: (teamRecord) =>
                                                teamRecord.where(
                                              'game',
                                              isEqualTo: game.reference,
                                            ),
                                          ),
                                          builder: (context, teamSnapshot) {
                                            final teams =
                                                teamSnapshot.data ?? [];
                                            final myTeam =
                                                teams.firstWhereOrNull(
                                              (t) => t.usersJob.any((uj) =>
                                                  uj.user?.id ==
                                                  currentUserReference?.id),
                                            );
                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  FFIcons.kusers,
                                                  color:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  size: 14.0,
                                                ),
                                                SizedBox(width: 4.0),
                                                Text(
                                                  myTeam?.name ?? '—',
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
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryText,
                                                        fontSize: 13.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        SizedBox(height: 8.0),
                                        StreamBuilder<
                                            List<GameRoundUserRecord>>(
                                          stream: queryGameRoundUserRecord(
                                            queryBuilder:
                                                (gameRoundUserRecord) =>
                                                    gameRoundUserRecord
                                                        .where(
                                                          'game',
                                                          isEqualTo:
                                                              game.reference,
                                                        )
                                                        .where(
                                                          'user',
                                                          isEqualTo:
                                                              currentUserReference,
                                                        ),
                                          ),
                                          builder: (context, roundSnapshot) {
                                            final roundUsers =
                                                roundSnapshot.data ?? [];
                                            final died = roundUsers
                                                .any((r) => r.isDead);
                                            return Text(
                                              died ? 'Погиб ✗' : 'Выжил ✓',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: died
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .error
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                        fontSize: 13.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      wrapWithModel(
                        model: _model.gameStatusListenerModel,
                        updateCallback: () => safeSetState(() {}),
                        child: GameStatusListenerWidget(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
