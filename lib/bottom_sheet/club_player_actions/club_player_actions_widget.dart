import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/dialog/club_remove_user/club_remove_user_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

/// Club-only bottom sheet shown from the "..." menu next to a player on the
/// game-management screen. Groups the per-player actions available to the club
/// (game creator): make the player captain of their team, and remove the
/// player from the team/game.
class ClubPlayerActionsWidget extends StatefulWidget {
  const ClubPlayerActionsWidget({
    super.key,
    required this.userJob,
    required this.teamDoc,
    required this.gameRef,
  });

  final UserJobStruct? userJob;
  final TeamRecord? teamDoc;
  final DocumentReference? gameRef;

  @override
  State<ClubPlayerActionsWidget> createState() =>
      _ClubPlayerActionsWidgetState();
}

class _ClubPlayerActionsWidgetState extends State<ClubPlayerActionsWidget> {
  Future<void> _makeCaptain(BuildContext context, String displayName) async {
    await widget!.teamDoc!.reference.update(createTeamRecordData(
      userCaptain: widget!.userJob?.user,
    ));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Игрок «$displayName» назначен капитаном',
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
    final isCaptain = widget!.teamDoc?.userCaptain == widget!.userJob?.user;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
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
              final userRecord = snapshot.data!;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 8.0),
                          child: Text(
                            userRecord.displayName,
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (!isCaptain)
                          _menuItem(
                            context,
                            icon: FFIcons.kcrownStar,
                            iconColor: FlutterFlowTheme.of(context).primaryText,
                            label: 'Сделать капитаном',
                            onTap: () =>
                                _makeCaptain(context, userRecord.displayName),
                          ),
                        _menuItem(
                          context,
                          icon: FFIcons.kxsquare,
                          iconColor: FlutterFlowTheme.of(context).error,
                          labelColor: FlutterFlowTheme.of(context).error,
                          label: 'Удалить из команды',
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return Dialog(
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  alignment: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  child: WebViewAware(
                                    child: ClubRemoveUserWidget(
                                      userJob: widget!.userJob,
                                      teamDoc: widget!.teamDoc,
                                      gameRef: widget!.gameRef,
                                    ),
                                  ),
                                );
                              },
                            );
                            if (mounted) {
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required Future<void> Function() onTap,
    Color? labelColor,
  }) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(icon, color: iconColor, size: 20.0),
                    Text(
                      label,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(),
                            color: labelColor,
                            fontSize: 15.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
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
    );
  }
}
