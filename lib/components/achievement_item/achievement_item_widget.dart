import '/backend/backend.dart';
import '/components/fullscreen_image_viewer/fullscreen_image_viewer_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'achievement_item_model.dart';
export 'achievement_item_model.dart';

class AchievementItemWidget extends StatefulWidget {
  const AchievementItemWidget({
    super.key,
    this.achivDoc,
    required this.userAchievments,
    this.userDoc,
  });

  final AchievementRecord? achivDoc;
  final List<UserAchievementsRecord>? userAchievments;
  final UserRecord? userDoc;

  @override
  State<AchievementItemWidget> createState() => _AchievementItemWidgetState();
}

class _AchievementItemWidgetState extends State<AchievementItemWidget> {
  late AchievementItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AchievementItemModel());

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
      height: 185.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).accent2,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional(0.0, 0.0),
              children: [
                Container(
                  width: 64.0,
                  height: 64.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FullscreenImageViewer(imageUrl: widget!.achivDoc!.image),
                      ),
                    ),
                    child: Image.network(
                      widget!.achivDoc!.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    double perc = widget!.achivDoc?.type == 0
                        ? functions.setProgressBarINT(
                        valueOrDefault(widget!.userDoc?.kilss, 0),
                        widget!.achivDoc!.maxKills)
                        : (widget!.achivDoc?.type == 1
                        ? functions.setProgressBarINT(
                        valueOrDefault(
                            widget!.userDoc?.gameCount, 0),
                        widget!.achivDoc!.gameCount)
                        : (widget!.achivDoc?.type == 2
                        ? functions.setProgressBarDouble(
                        valueOrDefault(
                            widget!.userDoc?.rate, 0.0),
                        widget!.achivDoc!.rate)
                        : (widget!.achivDoc?.type == 3
                        ? functions.setProgressBarINT(
                        functions.calculateMaxWinSeries(
                            (widget!.userDoc?.seriesNoLosess
                                ?.toList() ??
                                [])
                                .toList()),
                        widget!.achivDoc!.winSeries)
                        : (widget!.achivDoc?.type == 4
                        ? functions.setProgressBarINT(
                        valueOrDefault(
                            widget!.userDoc?.win, 0),
                        widget!.achivDoc!.winsCount)
                        : 0.0))));

                    if (perc > 1) {
                      perc = 1;
                    }

                    return IgnorePointer(
                      child: CircularPercentIndicator(
                        percent: perc,
                        radius: 32.5,
                        lineWidth: 3.0,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: FlutterFlowTheme.of(context).primary,
                      ),
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
              child: Text(
                valueOrDefault<String>(
                  widget!.achivDoc?.name,
                  'Название',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      fontSize: 13.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 8.0),
              child: Text(
                valueOrDefault<String>(
                  widget!.achivDoc?.text,
                  'Описание',
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 11.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
            if (widget!.userAchievments
                    ?.where((e) => e.achievement == widget!.achivDoc?.reference)
                    .toList()
                    ?.length ==
                0)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 2.0, 0.0),
                    child: Text(
                      'Прогресс:',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 11.0,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      '${widget!.achivDoc?.type == 0 ? valueOrDefault(widget!.userDoc?.kilss, 0).toString() : (widget!.achivDoc?.type == 1 ? valueOrDefault(widget!.userDoc?.gameCount, 0).toString() : (widget!.achivDoc?.type == 2 ? valueOrDefault(widget!.userDoc?.rate, 0.0).toString() : (widget!.achivDoc?.type == 3 ? functions.calculateMaxWinSeries((widget!.userDoc?.seriesNoLosess?.toList() ?? []).toList()).toString() : (widget!.achivDoc?.type == 4 ? valueOrDefault(widget!.userDoc?.kilss, 0).toString() : ''))))}/${widget!.achivDoc?.type == 0 ? widget!.achivDoc?.maxKills?.toString() : (widget!.achivDoc?.type == 1 ? widget!.achivDoc?.gameCount?.toString() : (widget!.achivDoc?.type == 2 ? widget!.achivDoc?.rate?.toString() : (widget!.achivDoc?.type == 3 ? widget!.achivDoc?.winSeries?.toString() : (widget!.achivDoc?.type == 4 ? widget!.achivDoc?.winsCount?.toString() : ''))))}',
                      '0',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          fontSize: 11.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontStyle,
                        ),
                  ),
                ],
              ),
            if (widget!.userAchievments!
                    .where((e) => e.achievement == widget!.achivDoc?.reference)
                    .toList()
                    .length >
                0)
              Text(
                'Получено',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primary,
                      fontSize: 11.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
