import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/color_choose_item/color_choose_item_widget.dart';
import '/components/general_buttom/general_buttom_widget.dart';
import '/dialog/notification/notification_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'create_edit_team_model.dart';
export 'create_edit_team_model.dart';

class CreateEditTeamWidget extends StatefulWidget {
  const CreateEditTeamWidget({
    super.key,
    this.teamDoc,
    this.colorIsSet,
    required this.gameRef,
    this.colorsUsed,
  });

  final TeamRecord? teamDoc;
  final bool? colorIsSet;
  final DocumentReference? gameRef;
  final List<Color>? colorsUsed;

  @override
  State<CreateEditTeamWidget> createState() => _CreateEditTeamWidgetState();
}

class _CreateEditTeamWidgetState extends State<CreateEditTeamWidget> {
  late CreateEditTeamModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateEditTeamModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget!.teamDoc != null) {
        _model.colorSelected = widget!.teamDoc?.color;
        _model.allowFreeJoin = widget!.teamDoc?.allowFreeJoin ?? false;
        safeSetState(() {});
      }
    });

    _model.textFieldDescriptionTextController1 ??= TextEditingController(
        text: widget!.teamDoc != null ? widget!.teamDoc?.name : '');
    _model.textFieldDescriptionFocusNode1 ??= FocusNode();

    _model.textFieldDescriptionTextController2 ??= TextEditingController(
        text: widget!.teamDoc != null ? widget!.teamDoc?.description : '');
    _model.textFieldDescriptionFocusNode2 ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<List<TeamRecord>>(
          stream: queryTeamRecord(
            queryBuilder: (teamRecord) => teamRecord.where(
              'game',
              isEqualTo: widget!.teamDoc?.game ?? widget!.gameRef,
            ),
          ),
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
            List<TeamRecord> containerTeamRecordList = snapshot.data!;

            return Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: FutureBuilder<List<JobRecord>>(
                future: queryJobRecordOnce(
                  queryBuilder: (jobRecord) => jobRecord.where(
                    'index',
                    isEqualTo: 0,
                  ),
                  singleRecord: true,
                ),
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
                  List<JobRecord> containerJobRecordList = snapshot.data!;
                  // Return an empty Container when the item does not exist.
                  if (snapshot.data!.isEmpty) {
                    return Container();
                  }
                  final containerJobRecord = containerJobRecordList.isNotEmpty
                      ? containerJobRecordList.first
                      : null;

                  return Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 8.0, 16.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 8.0),
                                child: Text(
                                  widget!.teamDoc != null
                                      ? 'Редактирование команды'
                                      : 'Создание команды',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 16.0, 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 4.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Цвет команды:',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            fontSize: 13.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 0.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final teamColorsList = functions
                                        .getColorsListsDifference(
                                            FFAppState().teamColors.toList(),
                                            containerTeamRecordList
                                                .where((e) =>
                                                    e.game == widget!.gameRef)
                                                .toList()
                                                .map((e) => e.color)
                                                .withoutNulls
                                                .toList())
                                        .toList();

                                    return Wrap(
                                      spacing: 0.0,
                                      runSpacing: 0.0,
                                      alignment: WrapAlignment.start,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      direction: Axis.horizontal,
                                      runAlignment: WrapAlignment.start,
                                      verticalDirection: VerticalDirection.down,
                                      clipBehavior: Clip.none,
                                      children:
                                          List.generate(teamColorsList.length,
                                              (teamColorsListIndex) {
                                        final teamColorsListItem =
                                            teamColorsList[teamColorsListIndex];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.colorSelected =
                                                teamColorsListItem;
                                            safeSetState(() {});
                                          },
                                          child: wrapWithModel(
                                            model: _model.colorChooseItemModels
                                                .getModel(
                                              teamColorsListIndex.toString(),
                                              teamColorsListIndex,
                                            ),
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: ColorChooseItemWidget(
                                              key: Key(
                                                'Keyhct_${teamColorsListIndex.toString()}',
                                              ),
                                              colorActiv: teamColorsListItem ==
                                                  _model.colorSelected,
                                              color: teamColorsListItem,
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 4.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Заняты другими:',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 13.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 0.0, 0.0),
                                      child: Builder(
                                        builder: (context) {
                                          final usedColor =
                                              containerTeamRecordList
                                                  .where((e) =>
                                                      e.game == widget!.gameRef)
                                                  .toList()
                                                  .map((e) => e.color)
                                                  .withoutNulls
                                                  .toList();

                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                    usedColor.length,
                                                    (usedColorIndex) {
                                              final usedColorItem =
                                                  usedColor[usedColorIndex];
                                              return Container(
                                                width: 14.0,
                                                height: 14.0,
                                                decoration: BoxDecoration(
                                                  color: usedColorItem,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                              );
                                            })
                                                .divide(SizedBox(width: 4.0))
                                                .addToEnd(SizedBox(width: 4.0)),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 16.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: _model
                                        .textFieldDescriptionTextController1,
                                    focusNode:
                                        _model.textFieldDescriptionFocusNode1,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.textFieldDescriptionTextController1',
                                      Duration(milliseconds: 100),
                                      () => safeSetState(() {}),
                                    ),
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Название команды',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color:
                                                (_model.textFieldDescriptionFocusNode1
                                                                ?.hasFocus ??
                                                            false) ==
                                                        true
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                            fontSize:
                                                (_model.textFieldDescriptionFocusNode1
                                                                ?.hasFocus ??
                                                            false) ==
                                                        true
                                                    ? 12.0
                                                    : 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      alignLabelWithHint: false,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .accent1,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              16.0, 14.0, 16.0, 14.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    maxLength: 15,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .textFieldDescriptionTextController1Validator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: _model
                                        .textFieldDescriptionTextController2,
                                    focusNode:
                                        _model.textFieldDescriptionFocusNode2,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.textFieldDescriptionTextController2',
                                      Duration(milliseconds: 100),
                                      () => safeSetState(() {}),
                                    ),
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Описание',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color:
                                                (_model.textFieldDescriptionFocusNode2
                                                                ?.hasFocus ??
                                                            false) ==
                                                        true
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                            fontSize:
                                                (_model.textFieldDescriptionFocusNode2
                                                                ?.hasFocus ??
                                                            false) ==
                                                        true
                                                    ? 12.0
                                                    : 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      alignLabelWithHint: false,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .accent1,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              16.0, 14.0, 16.0, 14.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    maxLength: 200,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .textFieldDescriptionTextController2Validator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              safeSetState(() {
                                _model.allowFreeJoin = !_model.allowFreeJoin;
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Checkbox(
                                  value: _model.allowFreeJoin,
                                  onChanged: (val) {
                                    safeSetState(() {
                                      _model.allowFreeJoin = val!;
                                    });
                                  },
                                  side: BorderSide(
                                    width: 2,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                  ),
                                  activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                  checkColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                                Text(
                                  'Разрешить вступление без заявки',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Builder(
                                builder: (context) => wrapWithModel(
                                  model: _model.generalButtomModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: GeneralButtomWidget(
                                    title: widget!.teamDoc != null
                                        ? 'Сохранить'
                                        : 'Создать команду',
                                    isActive: (_model
                                                    .textFieldDescriptionTextController1
                                                    .text !=
                                                null &&
                                            _model.textFieldDescriptionTextController1
                                                    .text !=
                                                '') &&
                                        (_model.textFieldDescriptionTextController2
                                                    .text !=
                                                null &&
                                            _model.textFieldDescriptionTextController2
                                                    .text !=
                                                '') &&
                                        (_model.colorSelected != null),
                                    ignoreIsActive: false,
                                    onTap: () async {
                                      if (widget!.teamDoc != null) {
                                        await widget!.teamDoc!.reference
                                            .update(createTeamRecordData(
                                          name: _model
                                              .textFieldDescriptionTextController1
                                              .text,
                                          color: _model.colorSelected,
                                          description: _model
                                              .textFieldDescriptionTextController2
                                              .text,
                                          creator: currentUserReference,
                                          recruitmentOpen: false,
                                          allowFreeJoin: _model.allowFreeJoin,
                                        ));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Изменения сохранены',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 13.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            duration:
                                                Duration(milliseconds: 1550),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .success,
                                          ),
                                        );
                                      } else {
                                        var teamRecordReference =
                                            TeamRecord.collection.doc();
                                        await teamRecordReference.set({
                                          ...createTeamRecordData(
                                            name: _model
                                                .textFieldDescriptionTextController1
                                                .text,
                                            color: _model.colorSelected,
                                            description: _model
                                                .textFieldDescriptionTextController2
                                                .text,
                                            creator: currentUserReference,
                                            recruitmentOpen: true,
                                            userCaptain: currentUserReference,
                                            game: widget!.gameRef,
                                            allowFreeJoin: _model.allowFreeJoin,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'usersJob': [
                                                getUserJobFirestoreData(
                                                  createUserJobStruct(
                                                    user: currentUserReference,
                                                    job: containerJobRecord
                                                        ?.reference,
                                                    clearUnsetFields: false,
                                                    create: true,
                                                  ),
                                                  true,
                                                )
                                              ],
                                            },
                                          ),
                                        });
                                        _model.teamCreated =
                                            TeamRecord.getDocumentFromData({
                                          ...createTeamRecordData(
                                            name: _model
                                                .textFieldDescriptionTextController1
                                                .text,
                                            color: _model.colorSelected,
                                            description: _model
                                                .textFieldDescriptionTextController2
                                                .text,
                                            creator: currentUserReference,
                                            recruitmentOpen: true,
                                            userCaptain: currentUserReference,
                                            game: widget!.gameRef,
                                            allowFreeJoin: _model.allowFreeJoin,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'usersJob': [
                                                getUserJobFirestoreData(
                                                  createUserJobStruct(
                                                    user: currentUserReference,
                                                    job: containerJobRecord
                                                        ?.reference,
                                                    clearUnsetFields: false,
                                                    create: true,
                                                  ),
                                                  true,
                                                )
                                              ],
                                            },
                                          ),
                                        }, teamRecordReference);

                                        await widget!.gameRef!.update({
                                          ...mapToFirestore(
                                            {
                                              'teams': FieldValue.arrayUnion([
                                                _model.teamCreated?.reference
                                              ]),
                                            },
                                          ),
                                        });
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: WebViewAware(
                                                child: NotificationWidget(
                                                  mainTttle: 'Команда создана!',
                                                  subTitle:
                                                      'Вы успешно создали команду «${_model.teamCreated?.name}». Теперь вы можете приглашать игроков и управлять командой.',
                                                  icon: Icon(
                                                    FFIcons.kchecksquare,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .success,
                                                    size: 30.0,
                                                  ),
                                                  title: 'Продолжить',
                                                  color: Color(0x1F31C455),
                                                  action: () async {
                                                    context.pushNamed(
                                                      AboutGamePageWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'gameReferens':
                                                            serializeParam(
                                                          widget!.gameRef,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      }.withoutNulls,
                                                    );

                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }

                                      Navigator.pop(context);

                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
