import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Club-only bottom sheet: directly add a player (not yet in the game) to a
/// specific team, bypassing the application/invitation flow.
///
/// Respects the game's [playersLimit]. Writes the user into [Team.usersJob]
/// (with the default job) and into [Game.users] — mirroring the join that
/// happens when a player accepts an invitation.
class ClubInvitePlayerWidget extends StatefulWidget {
  const ClubInvitePlayerWidget({
    super.key,
    required this.gameRef,
    required this.teamRef,
  });

  final DocumentReference? gameRef;
  final DocumentReference? teamRef;

  @override
  State<ClubInvitePlayerWidget> createState() => _ClubInvitePlayerWidgetState();
}

class _ClubInvitePlayerWidgetState extends State<ClubInvitePlayerWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSaving = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: StreamBuilder<GameRecord>(
            stream: GameRecord.getDocument(widget!.gameRef!),
            builder: (context, gameSnapshot) {
              if (!gameSnapshot.hasData) {
                return _loader(context);
              }
              final gameRecord = gameSnapshot.data!;

              return StreamBuilder<TeamRecord>(
                stream: TeamRecord.getDocument(widget!.teamRef!),
                builder: (context, teamSnapshot) {
                  if (!teamSnapshot.hasData) {
                    return _loader(context);
                  }
                  final teamRecord = teamSnapshot.data!;
                  final isTeamFull =
                      teamRecord.usersJob.length >= gameRecord.playersLimit;

                  return Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 8.0),
                          child: Text(
                            'Пригласить игрока в «${teamRecord.name}»',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 8.0),
                          child: Text(
                            'Игроки: ${teamRecord.usersJob.length}/${gameRecord.playersLimit}',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: isTeamFull
                                      ? FlutterFlowTheme.of(context).error
                                      : FlutterFlowTheme.of(context)
                                          .secondaryText,
                                  fontSize: 13.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                        TextFormField(
                          controller: _searchController,
                          onChanged: (value) => safeSetState(
                              () => _searchQuery = value.trim().toLowerCase()),
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Поиск по имени',
                            prefixIcon: Icon(
                              FFIcons.knavbar01,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 18.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).accent1,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(),
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 0.0),
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.sizeOf(context).height * 0.45,
                            ),
                            child: _buildPlayerList(
                              context,
                              gameRecord: gameRecord,
                              teamRecord: teamRecord,
                              isTeamFull: isTeamFull,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerList(
    BuildContext context, {
    required GameRecord gameRecord,
    required TeamRecord teamRecord,
    required bool isTeamFull,
  }) {
    return FutureBuilder<List<UserRecord>>(
      future: queryUserRecordOnce(
        queryBuilder: (userRecord) => userRecord.where('type', isEqualTo: 0),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return _loader(context);
        }
        final alreadyInGame =
            gameRecord.users.map((e) => e.id).toSet();
        final players = snapshot.data!
            .where((u) => !alreadyInGame.contains(u.reference.id))
            .where((u) => _searchQuery.isEmpty
                ? true
                : u.displayName.toLowerCase().contains(_searchQuery))
            .toList();

        if (players.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Нет доступных игроков',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(),
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 13.0,
                    letterSpacing: 0.0,
                  ),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: players.length,
          separatorBuilder: (_, __) => SizedBox(height: 8.0),
          itemBuilder: (context, index) {
            final player = players[index];
            return InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: (_isSaving || isTeamFull)
                  ? null
                  : () => _addPlayer(context, player, teamRecord),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).accent2,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 40.0,
                        height: 40.0,
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
                            if (player.photoUrl != '')
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  player.photoUrl,
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 0.0, 0.0),
                          child: Text(
                            player.displayName,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(),
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Icon(
                        FFIcons.kplussquare,
                        color: isTeamFull
                            ? FlutterFlowTheme.of(context).secondaryText
                            : FlutterFlowTheme.of(context).primary,
                        size: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _addPlayer(
    BuildContext context,
    UserRecord player,
    TeamRecord teamRecord,
  ) async {
    safeSetState(() => _isSaving = true);
    try {
      // Default job (index 0) — same one used when a player joins a team.
      final defaultJob = await queryJobRecordOnce(
        queryBuilder: (jobRecord) => jobRecord.where('index', isEqualTo: 0),
        singleRecord: true,
      );
      final jobRef = defaultJob.firstOrNull?.reference;

      await widget!.teamRef!.update({
        ...mapToFirestore(
          {
            'usersJob': FieldValue.arrayUnion([
              getUserJobFirestoreData(
                updateUserJobStruct(
                  UserJobStruct(
                    user: player.reference,
                    job: jobRef,
                  ),
                  clearUnsetFields: false,
                ),
                true,
              )
            ]),
          },
        ),
      });

      await widget!.gameRef!.update({
        ...mapToFirestore(
          {
            'users': FieldValue.arrayUnion([player.reference]),
          },
        ),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Игрок «${player.displayName}» добавлен в команду «${teamRecord.name}»',
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
    } finally {
      if (mounted) {
        safeSetState(() => _isSaving = false);
      }
    }
  }

  Widget _loader(BuildContext context) => Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
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
