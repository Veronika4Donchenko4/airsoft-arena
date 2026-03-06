import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'confirmation_game_dialog_model.dart';
export 'confirmation_game_dialog_model.dart';

class ConfirmationGameDialogWidget extends StatefulWidget {
  const ConfirmationGameDialogWidget({
    super.key,
    required this.gameDoc,
    this.teams,
  });

  final GameRecord? gameDoc;
  final List<TeamRecord>? teams;

  @override
  State<ConfirmationGameDialogWidget> createState() =>
      _ConfirmationGameDialogWidgetState();
}

class _ConfirmationGameDialogWidgetState
    extends State<ConfirmationGameDialogWidget> {
  late ConfirmationGameDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConfirmationGameDialogModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).accent2,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).warning,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      FFIcons.kchecksquarewarning,
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      size: 40.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                child: Text(
                  'Убедитесь, что все участники на площадке и готовы к игре',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                child: Text(
                  ' Вы уверены, что хотите начать игру?После начала игры внести изменения в состав команд будет невозможно.',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  if (_model.load == false) {
                    _model.load = true;
                    safeSetState(() {});

                    var gameRoundRecordReference =
                        GameRoundRecord.collection.doc();
                    await gameRoundRecordReference
                        .set(createGameRoundRecordData(
                      status: 0,
                      game: widget!.gameDoc?.reference,
                      createdTime: getCurrentTimestamp,
                    ));
                    _model.roundCreated = GameRoundRecord.getDocumentFromData(
                        createGameRoundRecordData(
                          status: 0,
                          game: widget!.gameDoc?.reference,
                          createdTime: getCurrentTimestamp,
                        ),
                        gameRoundRecordReference);

                    // Авторасределение игроков без команды
                    final allTeams = widget!.teams ?? [];
                    final teamAssignments =
                        <DocumentReference, DocumentReference?>{};
                    // Сначала назначаем тех, кто уже в команде
                    for (final user in widget!.gameDoc!.users) {
                      final team = functions.getTeamIBelongsReference(
                          user, allTeams.toList());
                      if (team != null) teamAssignments[user] = team;
                    }
                    // Автораспределяем остальных по командам с наименьшим числом игроков
                    final autoDistributed = <DocumentReference, int>{
                      for (final t in allTeams) t.reference: 0,
                    };
                    final maxPlayers = widget!.gameDoc!.playersLimit;
                    for (final user in widget!.gameDoc!.users) {
                      if (!teamAssignments.containsKey(user)) {
                        DocumentReference? best;
                        int minCount = 999999;
                        for (final team in allTeams) {
                          final total = team.usersJob.length +
                              (autoDistributed[team.reference] ?? 0);
                          if ((maxPlayers == 0 || total < maxPlayers) &&
                              total < minCount) {
                            minCount = total;
                            best = team.reference;
                          }
                        }
                        teamAssignments[user] = best;
                        if (best != null) {
                          autoDistributed[best] =
                              (autoDistributed[best] ?? 0) + 1;
                        }
                      }
                    }

                    while (_model.usersSaveCounter <
                        widget!.gameDoc!.users.length) {
                      final currentUser = widget!.gameDoc!.users
                          .elementAtOrNull(_model.usersSaveCounter)!;
                      final assignedTeam = teamAssignments[currentUser];
                      var gameRoundUserRecordReference =
                          GameRoundUserRecord.collection.doc();
                      await gameRoundUserRecordReference
                          .set(createGameRoundUserRecordData(
                        game: widget!.gameDoc?.reference,
                        user: currentUser,
                        isDead: false,
                        kills: 0,
                        rating: 0.0,
                        dateTime: getCurrentTimestamp,
                        team: assignedTeam,
                        isReady: false,
                        roundReference: _model.roundCreated?.reference,
                      ));
                      _model.gameRounUserSaved =
                          GameRoundUserRecord.getDocumentFromData(
                              createGameRoundUserRecordData(
                                game: widget!.gameDoc?.reference,
                                user: currentUser,
                                isDead: false,
                                kills: 0,
                                rating: 0.0,
                                dateTime: getCurrentTimestamp,
                                team: assignedTeam,
                                isReady: false,
                                roundReference: _model.roundCreated?.reference,
                              ),
                              gameRoundUserRecordReference);
                      _model.addToGameRoundUsers(
                          _model.gameRounUserSaved!.reference);
                      _model.usersSaveCounter = _model.usersSaveCounter + 1;
                    }

                    await _model.roundCreated!.reference.update({
                      ...mapToFirestore(
                        {
                          'roundUsers': _model.gameRoundUsers,
                        },
                      ),
                    });

                    await widget!.gameDoc!.reference.update({
                      ...createGameRecordData(
                        status: 2,
                      ),
                      ...mapToFirestore(
                        {
                          'roundsRefs': FieldValue.arrayUnion(
                              [_model.roundCreated?.reference]),
                        },
                      ),
                    });

                    context.goNamed(StartGameClubPageWidget.routeName);

                    _model.load = false;
                    safeSetState(() {});
                  }

                  safeSetState(() {});
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: Color(0x33000000),
                        offset: Offset(
                          0.0,
                          2.0,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).accent2,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 10.0, 0.0, 10.0),
                        child: Text(
                          'Начать игру',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 14.0, 0.0, 14.0),
                      child: Text(
                        'Отмена',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
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
