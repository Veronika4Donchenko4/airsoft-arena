import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'color_choose_item_model.dart';
export 'color_choose_item_model.dart';

class ColorChooseItemWidget extends StatefulWidget {
  const ColorChooseItemWidget({
    super.key,
    bool? colorActiv,
    required this.color,
  }) : this.colorActiv = colorActiv ?? false;

  final bool colorActiv;
  final Color? color;

  @override
  State<ColorChooseItemWidget> createState() => _ColorChooseItemWidgetState();
}

class _ColorChooseItemWidgetState extends State<ColorChooseItemWidget> {
  late ColorChooseItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ColorChooseItemModel());

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
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
        child: Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: widget!.color,
            borderRadius: BorderRadius.circular(12.0),
          ),
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Visibility(
            visible: widget!.colorActiv,
            child: Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  width: 4.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
