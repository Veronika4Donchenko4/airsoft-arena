import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'radio_bottom_model.dart';
export 'radio_bottom_model.dart';

class RadioBottomWidget extends StatefulWidget {
  const RadioBottomWidget({
    super.key,
    bool? isActive,
  }) : this.isActive = isActive ?? false;

  final bool isActive;

  @override
  State<RadioBottomWidget> createState() => _RadioBottomWidgetState();
}

class _RadioBottomWidgetState extends State<RadioBottomWidget> {
  late RadioBottomModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RadioBottomModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(
              color: FlutterFlowTheme.of(context).secondaryText,
              width: 2.0,
            ),
          ),
        ),
        if (widget!.isActive)
          Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).primary,
              ),
            ),
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: 13.0,
              height: 13.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
                borderRadius: BorderRadius.circular(22.0),
              ),
            ),
          ),
      ],
    );
  }
}
