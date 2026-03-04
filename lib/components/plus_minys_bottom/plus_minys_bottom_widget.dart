import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'plus_minys_bottom_model.dart';
export 'plus_minys_bottom_model.dart';

class PlusMinysBottomWidget extends StatefulWidget {
  const PlusMinysBottomWidget({
    super.key,
    bool? withPlus,
    bool? isActiv,
    this.action,
  })  : this.withPlus = withPlus ?? false,
        this.isActiv = isActiv ?? false;

  final bool withPlus;
  final bool isActiv;
  final Future Function()? action;

  @override
  State<PlusMinysBottomWidget> createState() => _PlusMinysBottomWidgetState();
}

class _PlusMinysBottomWidgetState extends State<PlusMinysBottomWidget> {
  late PlusMinysBottomModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlusMinysBottomModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        if (widget!.isActiv) {
          await widget.action?.call();
        }
      },
      child: Container(
        decoration: BoxDecoration(),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 20.0, 20.0),
          child: Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: widget!.isActiv
                    ? FlutterFlowTheme.of(context).primaryText
                    : FlutterFlowTheme.of(context).secondaryText,
                width: 2.0,
              ),
            ),
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Stack(
              children: [
                if (widget!.withPlus)
                  Icon(
                    FFIcons.kplussquare,
                    color: widget!.isActiv
                        ? FlutterFlowTheme.of(context).primaryText
                        : FlutterFlowTheme.of(context).secondaryText,
                    size: 30.0,
                  ),
                if (widget!.withPlus == false)
                  Icon(
                    FFIcons.kminussquare,
                    color: widget!.isActiv
                        ? FlutterFlowTheme.of(context).primaryText
                        : FlutterFlowTheme.of(context).secondaryText,
                    size: 30.0,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
