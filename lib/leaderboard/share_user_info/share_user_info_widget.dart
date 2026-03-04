import '/backend/backend.dart';
import '/components/share_profile_photo/share_profile_photo_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'share_user_info_model.dart';
export 'share_user_info_model.dart';

class ShareUserInfoWidget extends StatefulWidget {
  const ShareUserInfoWidget({
    super.key,
    required this.userId,
  });

  final String? userId;

  static String routeName = 'ShareUserInfo';
  static String routePath = '/shareUserInfo/:userId';

  @override
  State<ShareUserInfoWidget> createState() => _ShareUserInfoWidgetState();
}

class _ShareUserInfoWidgetState extends State<ShareUserInfoWidget> {
  late ShareUserInfoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShareUserInfoModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: StreamBuilder<UserRecord>(
            stream: UserRecord.getDocument(
                functions.getUserReferenceById(widget!.userId!)),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                );
              }

              final containerUserRecord = snapshot.data!;

              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    wrapWithModel(
                      model: _model.shareProfilePhotoModel,
                      updateCallback: () => safeSetState(() {}),
                      child: ShareProfilePhotoWidget(
                        user: containerUserRecord.reference,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
