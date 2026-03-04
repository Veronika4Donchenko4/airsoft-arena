import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'team_accpset_statys_item_model.dart';
export 'team_accpset_statys_item_model.dart';

class TeamAccpsetStatysItemWidget extends StatefulWidget {
  const TeamAccpsetStatysItemWidget({
    super.key,
    this.teamDoc,
    Color? color,
    this.textStatus,
    this.textcolor,
  }) : this.color = color ?? const Color(0x24FFFFFF);

  final TeamRecord? teamDoc;
  final Color color;
  final String? textStatus;
  final Color? textcolor;

  @override
  State<TeamAccpsetStatysItemWidget> createState() =>
      _TeamAccpsetStatysItemWidgetState();
}

class _TeamAccpsetStatysItemWidgetState
    extends State<TeamAccpsetStatysItemWidget> {
  late TeamAccpsetStatysItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TeamAccpsetStatysItemModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 167.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).accent2,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                color: valueOrDefault<Color>(
                  widget!.teamDoc?.color,
                  FlutterFlowTheme.of(context).forTeam1,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Icon(
                FFIcons.kusersfour,
                color: FlutterFlowTheme.of(context).primaryBackground,
                size: 16.0,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
              child: Text(
                valueOrDefault<String>(
                  widget!.teamDoc?.name,
                  'TeamName',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      fontSize: 15.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: valueOrDefault<Color>(
                  widget!.color,
                  FlutterFlowTheme.of(context).warning,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 5.0, 8.0, 5.0),
                child: Text(
                  valueOrDefault<String>(
                    widget!.textStatus,
                    'Status',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: valueOrDefault<Color>(
                          widget!.textcolor,
                          FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        fontSize: 11.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
            ),
          ].divide(SizedBox(height: 4.0)),
        ),
      ),
    );
  }
}
