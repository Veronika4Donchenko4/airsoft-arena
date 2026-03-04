import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'general_buttom_model.dart';
export 'general_buttom_model.dart';

class GeneralButtomWidget extends StatefulWidget {
  const GeneralButtomWidget({
    super.key,
    required this.title,
    bool? isActive,
    this.icon,
    required this.onTap,
    double? height,
    bool? ignoreIsActive,
  })  : this.isActive = isActive ?? true,
        this.height = height ?? 48.0,
        this.ignoreIsActive = ignoreIsActive ?? false;

  final String? title;
  final bool isActive;
  final Widget? icon;
  final Future Function()? onTap;
  final double height;
  final bool ignoreIsActive;

  @override
  State<GeneralButtomWidget> createState() => _GeneralButtomWidgetState();
}

class _GeneralButtomWidgetState extends State<GeneralButtomWidget> {
  late GeneralButtomModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GeneralButtomModel());

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
      width: double.infinity,
      height: widget!.height,
      decoration: BoxDecoration(),
      child: Container(
        width: double.infinity,
        child: Stack(
          children: [
            if (widget!.isActive)
              Padding(
                padding: EdgeInsets.all(valueOrDefault<double>(
                  widget!.isActive ? 0.0 : 10.0,
                  0.0,
                )),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsets.all(valueOrDefault<double>(
                  widget!.isActive ? 4.0 : 0.0,
                  0.0,
                )),
                child: FFButtonWidget(
                  onPressed: () async {
                    if ((widget!.isActive || widget!.ignoreIsActive) &&
                        !_model.isLoading) {
                      _model.isLoading = true;
                      await widget.onTap?.call();
                    }
                    _model.isLoading = false;
                  },
                  text: widget!.title!,
                  icon: widget!.icon,
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: double.infinity,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: widget!.isActive
                        ? FlutterFlowTheme.of(context).primary
                        : Color(0xFF303136),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                      color: widget!.isActive
                          ? Color(0xFF070C13)
                          : Color(0xFF61636B),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      shadows: [
                        Shadow(
                          color: valueOrDefault<Color>(
                            widget!.isActive
                                ? Color(0x27ADE962)
                                : Colors.transparent,
                            Colors.transparent,
                          ),
                          offset: Offset(0.0, 8.0),
                          blurRadius: widget!.isActive ? 24.0 : 0.0,
                        )
                      ],
                    ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
