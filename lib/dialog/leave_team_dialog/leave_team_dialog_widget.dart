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
import 'leave_team_dialog_model.dart';
export 'leave_team_dialog_model.dart';

class LeaveTeamDialogWidget extends StatefulWidget {
  const LeaveTeamDialogWidget({
    super.key,
    required this.teamDoc,
    this.gameRef,
  });

  final TeamRecord? teamDoc;
  final DocumentReference? gameRef;

  @override
  State<LeaveTeamDialogWidget> createState() => _LeaveTeamDialogWidgetState();
}

class _LeaveTeamDialogWidgetState extends State<LeaveTeamDialogWidget> {
  late LeaveTeamDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LeaveTeamDialogModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(53.0, 0.0, 53.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).accent2,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 19.0, 16.0, 17.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
                    child: Text(
                      'Покидание команды',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 17.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
                    child: Text(
                      'Вы уверены, что хотите покинуть команду «${widget!.teamDoc?.name}${widget!.teamDoc?.userCaptain == currentUserReference ? '»? Ваша должность капитана будет автоматически передана следующему игроку по рейтингу.' : '»?'}',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.normal,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
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
              onTap: () async {
                if (widget!.teamDoc?.usersJob?.length == 1) {
                  await widget!.gameRef!.update({
                    ...mapToFirestore(
                      {
                        'teams': FieldValue.arrayRemove(
                            [widget!.teamDoc?.reference]),
                      },
                    ),
                  });
                  await widget!.teamDoc!.reference.delete();

                  context.goNamed(
                    AboutGamePageWidget.routeName,
                    queryParameters: {
                      'gameReferens': serializeParam(
                        widget!.gameRef,
                        ParamType.DocumentReference,
                      ),
                    }.withoutNulls,
                  );
                } else {
                  if (currentUserReference == widget!.teamDoc?.userCaptain) {
                    await widget!.teamDoc!.reference.update({
                      ...createTeamRecordData(
                        userCaptain: widget!.teamDoc?.usersJob
                            ?.where((e) => e.user != currentUserReference)
                            .toList()
                            ?.firstOrNull
                            ?.user,
                      ),
                      ...mapToFirestore(
                        {
                          'usersJob': getUserJobListFirestoreData(
                            functions.changeUserJobs(
                                currentUserReference!,
                                widget!.teamDoc!.usersJob
                                    .where(
                                        (e) => e.user != currentUserReference)
                                    .toList()
                                    .firstOrNull!
                                    .user!,
                                widget!.teamDoc!.usersJob.toList()),
                          ),
                        },
                      ),
                    });

                    await widget!.teamDoc!.reference.update({
                      ...mapToFirestore(
                        {
                          'usersJob': FieldValue.arrayRemove([
                            getUserJobFirestoreData(
                              updateUserJobStruct(
                                widget!.teamDoc?.usersJob
                                    ?.where(
                                        (e) => e.user == currentUserReference)
                                    .toList()
                                    ?.firstOrNull,
                                clearUnsetFields: false,
                              ),
                              true,
                            )
                          ]),
                        },
                      ),
                    });

                    context.goNamed(GamesPageWidget.routeName);
                  } else {
                    await widget!.teamDoc!.reference.update({
                      ...mapToFirestore(
                        {
                          'usersJob': FieldValue.arrayRemove([
                            getUserJobFirestoreData(
                              updateUserJobStruct(
                                widget!.teamDoc?.usersJob
                                    ?.where(
                                        (e) => e.user == currentUserReference)
                                    .toList()
                                    ?.firstOrNull,
                                clearUnsetFields: false,
                              ),
                              true,
                            )
                          ]),
                        },
                      ),
                    });

                    context.goNamed(GamesPageWidget.routeName);
                  }
                }

                Navigator.pop(context);
              },
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 11.0, 0.0, 11.0),
                      child: Text(
                        'Покинуть',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).error,
                              fontSize: 17.0,
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 11.0, 0.0, 12.0),
                      child: Text(
                        'Отмена',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.normal,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
