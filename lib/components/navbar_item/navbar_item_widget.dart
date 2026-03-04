import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'navbar_item_model.dart';
export 'navbar_item_model.dart';

class NavbarItemWidget extends StatefulWidget {
  const NavbarItemWidget({
    super.key,
    required this.title,
    bool? isActive,
    required this.icon,
  }) : this.isActive = isActive ?? false;

  final String? title;
  final bool isActive;
  final Widget? icon;

  @override
  State<NavbarItemWidget> createState() => _NavbarItemWidgetState();
}

class _NavbarItemWidgetState extends State<NavbarItemWidget> {
  late NavbarItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavbarItemModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42.0,
            decoration: BoxDecoration(
              color: widget!.isActive
                  ? FlutterFlowTheme.of(context).primary
                  : Color(0x0061636B),
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: widget!.icon!,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
            child: Text(
              valueOrDefault<String>(
                widget!.title,
                'Текст',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: widget!.isActive
                        ? FlutterFlowTheme.of(context).primary
                        : Color(0xFF61636B),
                    fontSize: 10.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
