import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/l10n/app_localizations.dart';
import 'package:devicenote/responsive_layout.dart';
import 'package:devicenote/utils/category_display.dart';
import 'package:flutter/material.dart';

class DeviceGridCard extends StatelessWidget {
  const DeviceGridCard({
    super.key,
    required this.device,
    required this.monthsRemaining,
    required this.onTap,
  });

  final Device device;
  final int monthsRemaining;
  final VoidCallback onTap;

  static double widthForLayout(ResponsiveLayoutInfo layout) {
    final columnWidth = layout.columnWidth();
    if (columnWidth.isFinite && columnWidth > 0) {
      return columnWidth * (2 / 3);
    }
    final fallback = layout.contentWidth * (2 / 3);
    if (fallback.isFinite && fallback > 0) {
      return fallback;
    }
    return 120.0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final remainLabel = monthsRemaining == 0
        ? l10n.homeDDayLabel
        : l10n.homeDdayMonthsLabel(monthsRemaining);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFBEE3F8),
                Color(0xFFC6F6D5),
              ],
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final hasBoundedHeight = constraints.maxHeight.isFinite;
              final rawWidth = constraints.maxWidth;
              final fallbackWidth = constraints.biggest.shortestSide;
              final effectiveWidth = rawWidth.isFinite && rawWidth > 0
                  ? rawWidth
                  : (fallbackWidth.isFinite && fallbackWidth > 0
                      ? fallbackWidth
                      : 120.0);
              final iconExtent = effectiveWidth * 0.5;
              const double paddingValue = 16;
              final textDirection = Directionality.of(context);
              const TextAlign textAlign = TextAlign.center;
              final hasFiniteHeight = hasBoundedHeight &&
                  constraints.maxHeight.isFinite &&
                  constraints.maxHeight > 0;
              final innerHeight = hasFiniteHeight
                  ? (constraints.maxHeight - paddingValue * 2)
                  : double.infinity;
              final rawTextMaxWidth = (constraints.maxWidth.isFinite
                      ? constraints.maxWidth
                      : effectiveWidth) -
                  paddingValue * 2;
              final fallbackTextWidth = effectiveWidth - paddingValue * 2;
              double textMaxWidth;
              if (rawTextMaxWidth.isFinite && rawTextMaxWidth > 0) {
                textMaxWidth = rawTextMaxWidth;
              } else if (fallbackTextWidth.isFinite && fallbackTextWidth > 0) {
                textMaxWidth = fallbackTextWidth;
              } else {
                textMaxWidth = effectiveWidth;
              }
              if (!textMaxWidth.isFinite || textMaxWidth <= 0) {
                textMaxWidth = 1.0;
              }
              final brandText = device.brand.trim();
              final modelNameText = device.name.trim();
              final hasBrandText = brandText.isNotEmpty;
              final hasModelNameText = modelNameText.isNotEmpty;
              double availableTextHeight = innerHeight;
              const double gapAfterIcon = 6;
              const double gapBetweenLines = 4.2;
              if (availableTextHeight.isFinite) {
                availableTextHeight -= iconExtent;
                availableTextHeight -= gapAfterIcon;
                availableTextHeight =
                    availableTextHeight.clamp(0.0, double.infinity);
              }
              final baseBrandStyle =
                  theme.textTheme.titleMedium ?? const TextStyle(fontSize: 16);
              final baseModelStyle =
                  theme.textTheme.bodyMedium ?? const TextStyle(fontSize: 14);
              final baseRemainStyle =
                  theme.textTheme.labelMedium ?? const TextStyle(fontSize: 12);
              final linePainters = <TextPainter>[];
              if (hasBrandText) {
                linePainters.add(TextPainter(
                  text: TextSpan(style: baseBrandStyle, text: brandText),
                  maxLines: 1,
                  ellipsis: '...',
                  textAlign: textAlign,
                  textDirection: textDirection,
                )..layout(maxWidth: textMaxWidth));
              }
              if (hasModelNameText) {
                linePainters.add(TextPainter(
                  text: TextSpan(style: baseModelStyle, text: modelNameText),
                  maxLines: 1,
                  ellipsis: '...',
                  textAlign: textAlign,
                  textDirection: textDirection,
                )..layout(maxWidth: textMaxWidth));
              }
              final remainBasePainter = TextPainter(
                text: TextSpan(
                  style: baseRemainStyle,
                  text: remainLabel,
                ),
                maxLines: 1,
                ellipsis: '...',
                textAlign: textAlign,
                textDirection: textDirection,
              )..layout(maxWidth: textMaxWidth);
              linePainters.add(remainBasePainter);
              final visibleLineCount = linePainters.length;
              final totalGapHeight =
                  visibleLineCount > 1 ? gapBetweenLines * (visibleLineCount - 1) : 0;
              if (availableTextHeight.isFinite) {
                availableTextHeight =
                    (availableTextHeight - totalGapHeight).clamp(0.0, double.infinity);
              }
              final totalBaseTextHeight = linePainters.fold<double>(
                0,
                (sum, painter) => sum + painter.height,
              );
              const double maxMultiplier = 2.0;
              double responsiveMultiplier = maxMultiplier;
              if (availableTextHeight.isFinite && totalBaseTextHeight > 0) {
                final fitRatio = availableTextHeight <= 0
                    ? 0.0
                    : availableTextHeight / totalBaseTextHeight;
                responsiveMultiplier = fitRatio.clamp(0.0, maxMultiplier);
                const double minReadableMultiplier = 0.7;
                final canFitMinReadable =
                    totalBaseTextHeight * minReadableMultiplier <= availableTextHeight;
                if (responsiveMultiplier < minReadableMultiplier &&
                    canFitMinReadable) {
                  responsiveMultiplier = minReadableMultiplier;
                }
              }
              if (!availableTextHeight.isFinite || totalBaseTextHeight == 0) {
                responsiveMultiplier = maxMultiplier;
              }
              final brandTextStyle = baseBrandStyle.copyWith(
                fontSize:
                    (baseBrandStyle.fontSize ?? 16) * responsiveMultiplier,
                height: baseBrandStyle.height,
              );
              final modelTextStyle = baseModelStyle.copyWith(
                fontSize:
                    (baseModelStyle.fontSize ?? 14) * responsiveMultiplier,
                height: baseModelStyle.height,
              );
              final remainTextStyle = baseRemainStyle.copyWith(
                fontSize:
                    (baseRemainStyle.fontSize ?? 12) * responsiveMultiplier,
                color: theme.colorScheme.primary,
                height: baseRemainStyle.height,
              );
              final textWidgets = <Widget>[];
              if (hasBrandText) {
                textWidgets.add(
                  Text(
                    brandText,
                    style: brandTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: textAlign,
                  ),
                );
              }
              if (hasModelNameText) {
                textWidgets.add(
                  Text(
                    modelNameText,
                    style: modelTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: textAlign,
                  ),
                );
              }
              textWidgets.add(
                Text(
                  remainLabel,
                  style: remainTextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: textAlign,
                ),
              );
              final interleavedTexts = <Widget>[];
              for (var i = 0; i < textWidgets.length; i++) {
                if (i > 0) {
                  interleavedTexts.add(SizedBox(height: gapBetweenLines));
                }
                interleavedTexts.add(textWidgets[i]);
              }
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Icon(
                        categoryIcon(device.category),
                        color: theme.colorScheme.primary,
                        size: iconExtent,
                      ),
                    ),
                    SizedBox(height: gapAfterIcon),
                    ...interleavedTexts,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
