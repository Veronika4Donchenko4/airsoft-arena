import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'onboarding_indicator_model.dart';
export 'onboarding_indicator_model.dart';

class OnboardingIndicatorWidget extends StatefulWidget {
  const OnboardingIndicatorWidget({
    super.key,
    int? pagesCount,
    int? currentPage,
  })  : this.pagesCount = pagesCount ?? 4,
        this.currentPage = currentPage ?? 0;

  final int pagesCount;
  final int currentPage;

  @override
  State<OnboardingIndicatorWidget> createState() =>
      _OnboardingIndicatorWidgetState();
}

class _OnboardingIndicatorWidgetState extends State<OnboardingIndicatorWidget> {
  late OnboardingIndicatorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingIndicatorModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Builder(
          builder: (context) {
            final indiacators =
                functions.getIndicatorsList(widget!.pagesCount).toList();

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(indiacators.length, (indiacatorsIndex) {
                final indiacatorsItem = indiacators[indiacatorsIndex];
                return AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                  width: indiacatorsItem == widget!.currentPage ? 40.0 : 12.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: indiacatorsItem == widget!.currentPage
                        ? Colors.white
                        : Color(0xFF303136),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                );
              }).divide(SizedBox(width: 4.0)),
            );
          },
        ),
      ],
    );
  }
}
