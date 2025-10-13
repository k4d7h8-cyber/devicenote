import 'package:flutter/material.dart';

class ResponsiveLayoutInfo {
  const ResponsiveLayoutInfo({
    required this.screenWidth,
    required this.availableWidth,
    required this.columns,
    required this.padding,
    required this.gutter,
  });

  final double screenWidth;
  final double availableWidth;
  final int columns;
  final EdgeInsets padding;
  final double gutter;

  double get contentWidth =>
      (availableWidth - padding.horizontal).clamp(0, double.infinity);

  bool get isMobile => columns == 1;
  bool get isTablet => columns == 2;
  bool get isDesktop => columns >= 3;

  double columnWidth({int span = 1}) {
    final safeColumns = columns < 1 ? 1 : columns;
    final spanCount = span.clamp(1, safeColumns);
    final usableWidth = contentWidth;
    if (usableWidth <= 0) return 0;
    final totalGutter = gutter * (safeColumns - 1);
    final effectiveWidth = usableWidth - totalGutter;
    if (effectiveWidth <= 0) {
      return (usableWidth / spanCount).clamp(0, usableWidth) as double;
    }
    final baseWidth = effectiveWidth / safeColumns;
    final width = baseWidth * spanCount + gutter * (spanCount - 1);
    return width.clamp(0, usableWidth) as double;
  }
}

typedef ResponsiveBodyBuilder =
    Widget Function(BuildContext context, ResponsiveLayoutInfo layout);

class ResponsiveScaffold extends StatelessWidget {
  const ResponsiveScaffold({
    super.key,
    required this.builder,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.maxContentWidth = 1200,
    this.mobilePadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    this.tabletPadding = const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 24,
    ),
    this.desktopPadding = const EdgeInsets.symmetric(
      horizontal: 32,
      vertical: 32,
    ),
    this.gutter = 16,
    this.contentAlignment = Alignment.topCenter,
  });

  final ResponsiveBodyBuilder builder;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final double maxContentWidth;
  final EdgeInsets mobilePadding;
  final EdgeInsets tabletPadding;
  final EdgeInsets desktopPadding;
  final double gutter;
  final Alignment contentAlignment;

  static const double _tabletBreakpoint = 600;
  static const double _desktopBreakpoint = 1024;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton == null
          ? null
          : Padding(
              // Move left (increase right margin) and up (increase bottom margin)
              padding: const EdgeInsets.only(right: 50, bottom: 50),
              child: floatingActionButton,
            ),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final columns = width >= _desktopBreakpoint
              ? 3
              : width >= _tabletBreakpoint
              ? 2
              : 1;
          final padding = columns >= 3
              ? desktopPadding
              : columns == 2
              ? tabletPadding
              : mobilePadding;
          final availableWidth = width < maxContentWidth
              ? width
              : maxContentWidth;
          final info = ResponsiveLayoutInfo(
            screenWidth: width,
            availableWidth: availableWidth,
            columns: columns,
            padding: padding,
            gutter: gutter,
          );

          final media = MediaQuery.of(context);
          final viewInsetBottom = media.viewInsets.bottom;

          return SafeArea(
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(bottom: viewInsetBottom),
              child: Align(
                alignment: contentAlignment,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: info.availableWidth),
                    child: Padding(
                      padding: padding,
                      child: builder(context, info),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
