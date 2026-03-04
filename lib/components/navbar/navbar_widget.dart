import '/auth/firebase_auth/auth_util.dart';
import '/components/navbar_item/navbar_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'navbar_model.dart';
export 'navbar_model.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  late NavbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavbarModel());

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
        Container(
          width: double.infinity,
          height: 1.0,
          decoration: BoxDecoration(
            color: Color(0x81303136),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (valueOrDefault(currentUserDocument?.type, 0) == 0)
              Expanded(
                child: AuthUserStreamWidget(
                  builder: (context) => InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.goNamed(
                        GamesPageWidget.routeName,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    },
                    child: wrapWithModel(
                      model: _model.navbarItemModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: NavbarItemWidget(
                        title: 'Поиск игр',
                        isActive: FFAppState().navbarIndex == 0,
                        icon: Icon(
                          FFIcons.knavbar01,
                          color: FFAppState().navbarIndex == 0
                              ? Color(0xFF070C13)
                              : Color(0xFF61636B),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: AuthUserStreamWidget(
                builder: (context) => InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    if (valueOrDefault(currentUserDocument?.type, 0) == 0) {
                      context.goNamed(
                        MyGamePageWidget.routeName,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    } else {
                      context.goNamed(
                        GamesClubPageWidget.routeName,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    }
                  },
                  child: wrapWithModel(
                    model: _model.navbarItemModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: NavbarItemWidget(
                      title: valueOrDefault<String>(
                        valueOrDefault(currentUserDocument?.type, 0) == 0
                            ? 'Мои игры'
                            : 'Игры',
                        'Мои игры',
                      ),
                      isActive: FFAppState().navbarIndex == 1,
                      icon: Icon(
                        FFIcons.knavbar02,
                        color: FFAppState().navbarIndex == 1
                            ? Color(0xFF070C13)
                            : Color(0xFF61636B),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (valueOrDefault(currentUserDocument?.type, 0) == 0)
              Expanded(
                child: AuthUserStreamWidget(
                  builder: (context) => InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.goNamed(
                        LeaderboardPageWidget.routeName,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    },
                    child: wrapWithModel(
                      model: _model.navbarItemModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: NavbarItemWidget(
                        title: 'Лидерборд',
                        isActive: FFAppState().navbarIndex == 2,
                        icon: Icon(
                          FFIcons.knavbar03,
                          color: FFAppState().navbarIndex == 2
                              ? Color(0xFF070C13)
                              : Color(0xFF61636B),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.goNamed(
                    ChatPageWidget.routeName,
                    extra: <String, dynamic>{
                      kTransitionInfoKey: TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        duration: Duration(milliseconds: 0),
                      ),
                    },
                  );
                },
                child: wrapWithModel(
                  model: _model.navbarItemModel4,
                  updateCallback: () => safeSetState(() {}),
                  child: NavbarItemWidget(
                    title: 'Чат',
                    isActive: FFAppState().navbarIndex == 3,
                    icon: Icon(
                      FFIcons.knavbar04,
                      color: FFAppState().navbarIndex == 3
                          ? Color(0xFF070C13)
                          : Color(0xFF61636B),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.goNamed(
                    ProfilePageWidget.routeName,
                    extra: <String, dynamic>{
                      kTransitionInfoKey: TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        duration: Duration(milliseconds: 0),
                      ),
                    },
                  );
                },
                child: wrapWithModel(
                  model: _model.navbarItemModel5,
                  updateCallback: () => safeSetState(() {}),
                  child: NavbarItemWidget(
                    title: 'Профиль',
                    isActive: FFAppState().navbarIndex == 4,
                    icon: Icon(
                      FFIcons.knavbar05,
                      color: FFAppState().navbarIndex == 4
                          ? Color(0xFF070C13)
                          : Color(0xFF61636B),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
