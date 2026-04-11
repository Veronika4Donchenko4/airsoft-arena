import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/game_item/game_item_widget.dart';
import '/components/game_status_listener/game_status_listener_widget.dart';
import '/game/club_profile_page/club_profile_page_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/components/zero_item/zero_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'games_page_model.dart';
export 'games_page_model.dart';

class GamesPageWidget extends StatefulWidget {
  const GamesPageWidget({super.key});

  static String routeName = 'GamesPage';
  static String routePath = '/gamesPage';

  @override
  State<GamesPageWidget> createState() => _GamesPageWidgetState();
}

class _GamesPageWidgetState extends State<GamesPageWidget> {
  late GamesPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GamesPageModel());

    _model.clubSearchController ??= TextEditingController();
    _model.clubSearchFocusNode ??= FocusNode();
    _model.clubCityController ??= TextEditingController();
    _model.clubCityFocusNode ??= FocusNode();

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().navbarIndex = 0;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Segmented toggle
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _model.selectedTab = 0;
                            safeSetState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: _model.selectedTab == 0
                                  ? FlutterFlowTheme.of(context).primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              'Игры',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: _model.selectedTab == 0
                                        ? Colors.white
                                        : FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _model.selectedTab = 1;
                            safeSetState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: _model.selectedTab == 1
                                  ? FlutterFlowTheme.of(context).primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              'Клубы',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: _model.selectedTab == 1
                                        ? Colors.white
                                        : FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Games tab
                      if (_model.selectedTab == 0)
                        Container(
                          decoration: BoxDecoration(),
                          child: AuthUserStreamWidget(
                            builder: (context) =>
                                StreamBuilder<List<GameRecord>>(
                              stream: queryGameRecord(
                                queryBuilder: (gameRecord) => gameRecord
                                    .where(
                                      'placeId',
                                      isEqualTo:
                                          currentUserDocument?.city?.placeId,
                                    )
                                    .where(
                                      'status',
                                      isEqualTo: 0,
                                    ),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData &&
                                    snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                  return Center(
                                    child: SizedBox(
                                      width: 30.0,
                                      height: 30.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<GameRecord> containerGameRecordList =
                                    snapshot.data ?? [];

                                return Container(
                                  decoration: BoxDecoration(),
                                  child: SingleChildScrollView(
                                    primary: false,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 12.0, 16.0, 12.0),
                                          child: Text(
                                            'Список игр',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  fontSize: 24.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final gamesList =
                                                containerGameRecordList
                                                    .toList();
                                            if (gamesList.isEmpty) {
                                              return Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.9,
                                                child: ZeroItemWidget(
                                                  icon: Icon(
                                                    FFIcons.knavbar02,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 40.0,
                                                  ),
                                                  title:
                                                      'Игры скоро появятся!',
                                                  subTitlt:
                                                      'Пока в вашем городе не проходят игры. Станьте клубом и начните создавать игры для игроков прямо сейчас!',
                                                  withBottom: false,
                                                  action: () async {},
                                                ),
                                              );
                                            }

                                            return ListView.separated(
                                              padding: EdgeInsets.fromLTRB(
                                                0,
                                                16.0,
                                                0,
                                                16.0,
                                              ),
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: gamesList.length,
                                              separatorBuilder: (_, __) =>
                                                  SizedBox(height: 8.0),
                                              itemBuilder:
                                                  (context, gamesListIndex) {
                                                final gamesListItem =
                                                    gamesList[gamesListIndex];
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  child: wrapWithModel(
                                                    model: _model.gameItemModels
                                                        .getModel(
                                                      gamesListItem
                                                          .reference.id,
                                                      gamesListIndex,
                                                    ),
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child: GameItemWidget(
                                                      key: Key(
                                                        'Keybrt_${gamesListItem.reference.id}',
                                                      ),
                                                      game: gamesListItem,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      // Clubs tab
                      if (_model.selectedTab == 1)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 12.0, 16.0, 12.0),
                              child: Text(
                                'Список клубов',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            // Search by club name
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 8.0),
                              child: TextFormField(
                                controller: _model.clubSearchController,
                                focusNode: _model.clubSearchFocusNode,
                                onChanged: (_) => safeSetState(() {}),
                                decoration: InputDecoration(
                                  hintText: 'Поиск по названию',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  prefixIcon: Icon(
                                    FFIcons.kmagnifyingglass,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 20.0,
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 12.0),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            // Filter by city
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 12.0),
                              child: TextFormField(
                                controller: _model.clubCityController,
                                focusNode: _model.clubCityFocusNode,
                                onChanged: (_) => safeSetState(() {}),
                                decoration: InputDecoration(
                                  hintText: 'Фильтр по городу',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  prefixIcon: Icon(
                                    FFIcons.kmappin,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 20.0,
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 12.0),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            // Clubs list
                            StreamBuilder<List<UserRecord>>(
                              stream: queryUserRecord(
                                queryBuilder: (userRecord) =>
                                    userRecord.where('type', isEqualTo: 1),
                              ),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData &&
                                    snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                  return Center(
                                    child: SizedBox(
                                      width: 30.0,
                                      height: 30.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<UserRecord> allClubs =
                                    snapshot.data ?? [];

                                final searchQuery = _model
                                        .clubSearchController?.text
                                        .toLowerCase() ??
                                    '';
                                final cityQuery = _model
                                        .clubCityController?.text
                                        .toLowerCase() ??
                                    '';
                                final filteredClubs =
                                    allClubs.where((club) {
                                  final matchesName = searchQuery.isEmpty ||
                                      club.clubName
                                          .toLowerCase()
                                          .contains(searchQuery);
                                  final matchesCity = cityQuery.isEmpty ||
                                      club.city.description
                                          .toLowerCase()
                                          .contains(cityQuery);
                                  return matchesName && matchesCity;
                                }).toList();

                                if (filteredClubs.isEmpty) {
                                  return Container(
                                    height:
                                        MediaQuery.sizeOf(context).height *
                                            0.5,
                                    child: ZeroItemWidget(
                                      icon: Icon(
                                        FFIcons.kclub,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 40.0,
                                      ),
                                      title: 'Клубы не найдены',
                                      subTitlt:
                                          'Попробуйте изменить параметры поиска',
                                      withBottom: false,
                                      action: () async {},
                                    ),
                                  );
                                }

                                return ListView.separated(
                                  padding: EdgeInsets.fromLTRB(
                                      0, 0, 0, 16.0),
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: filteredClubs.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 8.0),
                                  itemBuilder: (context, index) {
                                    final club = filteredClubs[index];
                                    return Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 16.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            ClubProfilePageWidget.routeName,
                                            queryParameters: {
                                              'clubDoc': serializeParam(
                                                club,
                                                ParamType.Document,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              'clubDoc': club,
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                              ),
                                            },
                                          );
                                        },
                                        child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(
                                                  context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 48.0,
                                              height: 48.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                shape: BoxShape.circle,
                                                image: club.photoUrl
                                                        .isNotEmpty
                                                    ? DecorationImage(
                                                        image: NetworkImage(
                                                            club.photoUrl),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : null,
                                              ),
                                              child: club
                                                      .photoUrl.isEmpty
                                                  ? Center(
                                                      child: Icon(
                                                        FFIcons.kclub,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryText,
                                                        size: 24.0,
                                                      ),
                                                    )
                                                  : null,
                                            ),
                                            SizedBox(width: 12.0),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text(
                                                    club.clubName,
                                                    style: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .inter(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 16.0,
                                                          letterSpacing:
                                                              0.0,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  if (club.city.description
                                                      .isNotEmpty)
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.only(
                                                              top: 4.0),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            FFIcons
                                                                .kmappin,
                                                            color: FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                            size: 14.0,
                                                          ),
                                                          SizedBox(
                                                              width: 4.0),
                                                          Expanded(
                                                            child: Text(
                                                              club.city
                                                                  .description,
                                                              style: FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontStyle:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontStyle:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  if (club.clubDescription
                                                      .isNotEmpty)
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.only(
                                                              top: 6.0),
                                                      child: Text(
                                                        club
                                                            .clubDescription,
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodySmall
                                                            .override(
                                                              font: GoogleFonts
                                                                  .inter(
                                                                fontStyle:
                                                                    FlutterFlowTheme.of(context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      wrapWithModel(
                        model: _model.gameStatusListenerModel,
                        updateCallback: () => safeSetState(() {}),
                        child: GameStatusListenerWidget(),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  wrapWithModel(
                    model: _model.navbarModel,
                    updateCallback: () => safeSetState(() {}),
                    child: NavbarWidget(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
