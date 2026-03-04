import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/dialog/notification/notification_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'description_spore_model.dart';
export 'description_spore_model.dart';

class DescriptionSporeWidget extends StatefulWidget {
  const DescriptionSporeWidget({
    super.key,
    this.gameDoc,
    this.teamRef,
  });

  final GameRecord? gameDoc;
  final DocumentReference? teamRef;

  @override
  State<DescriptionSporeWidget> createState() => _DescriptionSporeWidgetState();
}

class _DescriptionSporeWidgetState extends State<DescriptionSporeWidget> {
  late DescriptionSporeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DescriptionSporeModel());

    _model.textFieldDescriptionTextController ??= TextEditingController();
    _model.textFieldDescriptionFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 8.0, 8.0),
                              child: Icon(
                                FFIcons.kupLeft,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 8.0),
                          child: Text(
                            'Подробное описание жалобы',
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
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).accent1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Пожалуйста, подробно опишите причину вашей жалобы. Укажите все детали, которые считаете важными.',
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
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _model.textFieldDescriptionTextController,
                          focusNode: _model.textFieldDescriptionFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.textFieldDescriptionTextController',
                            Duration(milliseconds: 100),
                            () => safeSetState(() {}),
                          ),
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Комментарий',
                            labelStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: (_model.textFieldDescriptionFocusNode
                                                  ?.hasFocus ??
                                              false) ==
                                          true
                                      ? FlutterFlowTheme.of(context).primaryText
                                      : FlutterFlowTheme.of(context)
                                          .secondaryText,
                                  fontSize: (_model
                                                  .textFieldDescriptionFocusNode
                                                  ?.hasFocus ??
                                              false) ==
                                          true
                                      ? 12.0
                                      : 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            alignLabelWithHint: false,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).accent1,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 14.0, 16.0, 14.0),
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 15.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                          maxLength: 200,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model
                              .textFieldDescriptionTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 16.0, 0.0, 16.0),
                        child: wrapWithModel(
                          model: _model.generalButtomModel,
                          updateCallback: () => safeSetState(() {}),
                          child: GeneralButtomWidget(
                            title: 'Отправить',
                            isActive: _model.textFieldDescriptionTextController
                                        .text !=
                                    null &&
                                _model.textFieldDescriptionTextController
                                        .text !=
                                    '',
                            ignoreIsActive: false,
                            onTap: () async {
                              var sporeRecordReference =
                                  SporeRecord.collection.doc();
                              await sporeRecordReference
                                  .set(createSporeRecordData(
                                description: _model
                                    .textFieldDescriptionTextController.text,
                                team: widget!.teamRef,
                                user: currentUserReference,
                                game: widget!.gameDoc?.reference,
                              ));
                              _model.newSpore = SporeRecord.getDocumentFromData(
                                  createSporeRecordData(
                                    description: _model
                                        .textFieldDescriptionTextController
                                        .text,
                                    team: widget!.teamRef,
                                    user: currentUserReference,
                                    game: widget!.gameDoc?.reference,
                                  ),
                                  sporeRecordReference);

                              await widget!.gameDoc!.reference.update({
                                ...mapToFirestore(
                                  {
                                    'sporeAboutGame': FieldValue.arrayUnion(
                                        [_model.newSpore?.reference]),
                                  },
                                ),
                              });
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
                                      child: NotificationWidget(
                                        title: 'Закрыть',
                                        icon: Icon(
                                          FFIcons.kchecksquare,
                                          color: FlutterFlowTheme.of(context)
                                              .success,
                                          size: 30.0,
                                        ),
                                        color: Color(0x1E31C455),
                                        mainTttle: 'Жалоба отправлена',
                                        subTitle:
                                            'Ваша жалоба успешно отправлена. Мы рассмотрим её в ближайшее время. ',
                                        action: () async {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );

                              Navigator.pop(context);

                              safeSetState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
