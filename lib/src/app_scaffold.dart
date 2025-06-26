import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

/**
 * ref: https://stackoverflow.com/questions/76584957/using-adaptivescaffold-from-flutter-adaptive-scaffold-with-go-router-to-show-a-l
 */
class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget? secondaryBody;

  const AppScaffold({
    Key? key,
    required this.body,
    this.secondaryBody,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('Body Small'),
            builder: (_) => secondaryBody != null ? secondaryBody! : body,
          ),
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('Body Medium'),
            builder: (_) => body,
          )
        },
      ),
      secondaryBody: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('Body Small'),
            builder: null,
          ),
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('Body Medium'),
            builder: secondaryBody != null
                ? (_) => secondaryBody!
                : AdaptiveScaffold.emptyBuilder,
          )
        },
      ),
    );
  }
}
