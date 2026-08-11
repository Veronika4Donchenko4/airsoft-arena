import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Club-only confirmation dialog that removes a player from a team/game at ANY
/// stage (lobby, in-progress, finished).
///
/// It removes the user from [Team.usersJob] and from [Game.users] (the single
/// source of truth for game participation / results aggregation), and deletes
/// any already-finalized [GameUser] doc for that user. It deliberately keeps
/// the user's [GameRoundUser] records intact so historical round/score data is
/// not corrupted — finalization only aggregates users still in [Game.users], so
/// orphan round docs are simply never read.
///
/// If the removed player is the team captain and other members remain, the
/// captaincy is handed to the next remaining member.
class ClubRemoveUserWidget extends StatefulWidget {
  const ClubRemoveUserWidget({
    super.key,
    required this.userJob,
    required this.teamDoc,
    required this.gameRef,
  });

  final UserJobStruct? userJob;
  final TeamRecord? teamDoc;
  final DocumentReference? gameRef;

  @override
  State<ClubRemoveUserWidget> createState() => _ClubRemoveUserWidgetState();
}

class _ClubRemoveUserWidgetState extends State<ClubRemoveUserWidget> {
  bool _isRemoving = false;

  Future<void> _remove(BuildContext context, String displayName) async {
    if (_isRemoving) return;
    safeSetState(() => _isRemoving = true);

    final removedUser = widget!.userJob?.user;
    final teamRef = widget!.teamDoc!.reference;

    // 1. If the removed player is the captain, hand captaincy to the next
    //    remaining member (if any) so the team isn't left captain-less.
    if (widget!.teamDoc?.userCaptain == removedUser) {
      final nextCaptain = widget!.teamDoc!.usersJob
          .where((e) => e.user != removedUser)
          .toList()
          .firstOrNull
          ?.user;
      await teamRef.update(createTeamRecordData(
        userCaptain: nextCaptain,
      ));
    }

    // 2. Remove the player from the team roster (Team.usersJob).
    await teamRef.update({
      ...mapToFirestore(
        {
          'usersJob': FieldValue.arrayRemove([
            getUserJobFirestoreData(
              updateUserJobStruct(
                widget!.userJob,
                clearUnsetFields: false,
              ),
              true,
            )
          ]),
        },
      ),
    });

    // 3. Remove the player from the game roster (Game.users) — this is what
    //    keeps them out of round-creation and results aggregation.
    if (removedUser != null) {
      await widget!.gameRef!.update({
        ...mapToFirestore(
          {
            'users': FieldValue.arrayRemove([removedUser]),
          },
        ),
      });

      // 4. If the game was already finalized, a GameUser aggregate doc exists.
      //    Delete it and drop it from Game.gameUsers. GameRoundUser docs are
      //    intentionally left untouched.
      final gameUsers = await queryGameUserRecordOnce(
        queryBuilder: (gameUserRecord) => gameUserRecord
            .where('game', isEqualTo: widget!.gameRef)
            .where('user', isEqualTo: removedUser),
      );
      for (final gameUser in gameUsers) {
        await widget!.gameRef!.update({
          ...mapToFirestore(
            {
              'gameUsers': FieldValue.arrayRemove([gameUser.reference]),
            },
          ),
        });
        await gameUser.reference.delete();
      }
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Игрок «$displayName» удалён из команды',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 13.0,
            ),
          ),
          duration: Duration(milliseconds: 3000),
          backgroundColor: FlutterFlowTheme.of(context).success,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(53.0, 0.0, 53.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).accent2,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: StreamBuilder<UserRecord>(
          stream: UserRecord.getDocument(widget!.userJob!.user!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.all(24.0),
                child: Center(
                  child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                ),
              );
            }
            final columnUserRecord = snapshot.data!;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 19.0, 16.0, 17.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Удаление игрока',
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: Text(
                          'Вы уверены, что хотите удалить игрока «${columnUserRecord.displayName}» из команды «${widget!.teamDoc?.name}»? Игровая статистика по раундам будет сохранена.',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.inter(),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 13.0,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => _remove(context, columnUserRecord.displayName),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).accent1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 11.0, 0.0, 11.0),
                          child: _isRemoving
                              ? SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).error,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Удалить',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
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
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 11.0, 0.0, 12.0),
                      child: Text(
                        'Отмена',
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.inter(),
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
