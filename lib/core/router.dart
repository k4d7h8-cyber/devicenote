import 'package:devicenote/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:devicenote/l10n/app_localizations.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      default:
        return MaterialPageRoute(
          builder: (_) => const _BootPage(),
          settings: settings,
        );
    }
  }
}

class _BootPage extends StatelessWidget {
  const _BootPage();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ResponsiveScaffold(
      builder: (context, layout) => Center(
        child: Text(l10n.bootPlaceholderMessage, textAlign: TextAlign.center),
      ),
    );
  }
}
