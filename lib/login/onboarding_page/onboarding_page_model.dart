import '/components/general_buttom/general_buttom_widget.dart';
import '/components/onboarding_indicator/onboarding_indicator_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'onboarding_page_widget.dart' show OnboardingPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnboardingPageModel extends FlutterFlowModel<OnboardingPageWidget> {
  ///  Local state fields for this page.

  int currentIndex = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for onboardingIndicator component.
  late OnboardingIndicatorModel onboardingIndicatorModel;
  // Model for general_buttom component.
  late GeneralButtomModel generalButtomModel;

  @override
  void initState(BuildContext context) {
    onboardingIndicatorModel =
        createModel(context, () => OnboardingIndicatorModel());
    generalButtomModel = createModel(context, () => GeneralButtomModel());
  }

  @override
  void dispose() {
    onboardingIndicatorModel.dispose();
    generalButtomModel.dispose();
  }
}
