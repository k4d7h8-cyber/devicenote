import 'package:devicenote/responsive_layout.dart';
import 'package:flutter/material.dart';

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

/// 1단계 확인용 임시 화면 (2단계에서 홈/등록/상세/설정으로 교체)
class _BootPage extends StatelessWidget {
  const _BootPage();

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: AppBar(title: const Text('DeviceNote')),
      builder: (context, layout) => const Center(
        child: Text(
          '1단계 준비 완료!\n다음 단계에서 UI(홈/등록/상세/설정)를 만들 예정입니다.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
