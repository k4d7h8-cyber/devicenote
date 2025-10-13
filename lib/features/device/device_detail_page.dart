import 'dart:io';

import 'package:devicenote/data/repositories/device_repository.dart';

import 'package:devicenote/responsive_layout.dart';

import 'package:devicenote/services/notifications/notification_controller.dart';

import 'package:devicenote/core/utils/date_utils.dart';

import 'package:flutter/material.dart';
import 'package:devicenote/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:provider/provider.dart';
import 'package:devicenote/utils/category_display.dart';

const double _menuItemExtent = 104;

class DeviceDetailPage extends StatelessWidget {
  final String id;

  const DeviceDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeName = l10n.localeName;
    final repo = context.watch<DeviceRepository>();

    final device = repo.findById(id);

    final notifications = context.watch<NotificationController>();

    if (device == null) {
      return ResponsiveScaffold(
        contentAlignment: Alignment.center,
        builder: (context, layout) =>
            Center(child: Text(l10n.deviceDetailNotFound)),
      );
    }

    final notificationPreference = notifications.devicePreference(device.id);

    final warrantyExpiry = DateUtilsX.addMonths(
      device.purchaseDate,
      device.warrantyMonths,
    );

    final expiryLabel = DateUtilsX.formatForLocale(
      warrantyExpiry,
      locale: localeName,
    );

    return ResponsiveScaffold(
      contentAlignment: Alignment.center,
      builder: (context, layout) {
        final cardWidth = layout.columnWidth();

        final theme = Theme.of(context);

        final customerCenter = device.asContact?.trim() ?? '';
        final hasCustomerCenter = customerCenter.isNotEmpty;

        final cards = <Widget>[
          _InfoCard(
            title: l10n.deviceDetailCategoryLabel,

            value: _categoryLabel(l10n, device.category),

            icon: categoryIcon(device.category),
          ),

          _InfoCard(
            title: l10n.deviceDetailBrandLabel,

            value: device.brand,

            icon: Icons.storefront,
          ),

          _InfoCard(
            title: l10n.deviceDetailModelNameLabel,

            value: device.name,

            icon: categoryIcon(device.category),
          ),

          _InfoCard(
            title: l10n.deviceDetailModelNumberLabel,

            value: device.model,

            icon: Icons.confirmation_number,
          ),

          _InfoCard(
            title: l10n.deviceDetailPurchaseDateLabel,

            value: DateUtilsX.formatForLocale(
              device.purchaseDate,
              locale: localeName,
            ),

            icon: Icons.event,
          ),

          _InfoCard(
            title: l10n.deviceDetailWarrantyLabel,

            value: device.warrantyMonths.toString(),

            icon: Icons.verified_user,
          ),
        ];

        if (hasCustomerCenter) {
          final colors = theme.colorScheme;
          cards.add(
            _InfoCard(
              title: l10n.deviceDetailCustomerCenterLabel,

              value: customerCenter,

              icon: Icons.phone,
              onTap: () => _callCustomerCenter(context, customerCenter),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            Wrap(
              spacing: layout.gutter,

              runSpacing: layout.gutter,

              children: [
                for (final card in cards)
                  SizedBox(width: cardWidth, child: card),
              ],
            ),

            const SizedBox(height: 24),

            Card(
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
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
                child: SwitchListTile.adaptive(
                  title: Text(l10n.deviceDetailNotificationsTitle),
                  subtitle: Text(
                    notifications.notificationsEnabled
                        ? l10n.deviceDetailNotificationsEnabled(expiryLabel)
                        : l10n.deviceDetailNotificationsDisabled,
                  ),
                  value: notificationPreference,

                  onChanged: (value) async {
                    await notifications.setDevicePreference(
                      context: context,

                      device: device,

                      enabled: value,
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFBEE3F8),
                          Color(0xFFC6F6D5),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        side: BorderSide.none,
                        minimumSize: const Size.fromHeight(60), // 1.5x taller
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      onPressed: () => context.push('/device/${device.id}/edit'),

                      icon: const Icon(Icons.edit),

                      label: Text(l10n.commonEdit),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFBEE3F8),
                          Color(0xFFC6F6D5),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        minimumSize: const Size.fromHeight(60), // 1.5x taller
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      onPressed: () => _confirmDelete(
                        context,

                        repo,

                        context.read<NotificationController>(),

                        device.id,
                      ),

                      icon: const Icon(Icons.delete_outline),

                      label: Text(l10n.commonDelete),
                    ),
                  ),
                ),
              ],
            ),

            if (device.imagePaths.isNotEmpty) ...[
              const SizedBox(height: 24),

              Text(
                l10n.deviceDetailPhotosSectionTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: 12),

              _PhotoCarousel(
                photos: device.imagePaths,

                thumbnailSize: _menuItemExtent,
              ),
            ],
          ],
        );
      },
    );
  }

  Future<void> _callCustomerCenter(
    BuildContext context,
    String rawNumber,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final sanitized = rawNumber.replaceAll(RegExp(r'[^0-9+]'), '');
    if (sanitized.isEmpty) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.deviceDetailCallError)),
      );
      return;
    }
    final uri = Uri(scheme: 'tel', path: sanitized);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.deviceDetailCallError)),
      );
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,

    DeviceRepository repo,

    NotificationController notifications,

    String id,
  ) async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx)!;
        return AlertDialog(
          title: Text(l10n.deviceDetailDeleteDialogTitle),
          content: Text(l10n.deviceDetailDeleteDialogMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.commonCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(l10n.commonDelete),
            ),
          ],
        );
      },
    );

    if (yes == true) {
      if (!context.mounted) return;

      final navigator = Navigator.of(context);

      await notifications.onDeviceRemoved(id);

      await repo.remove(id);

      if (navigator.mounted) navigator.pop();
    }
  }

  String _categoryLabel(AppLocalizations l10n, DeviceCategory c) {
    switch (c) {
      case DeviceCategory.tv:
        return l10n.categoryTv;

      case DeviceCategory.washer:
        return l10n.categoryWasher;

      case DeviceCategory.computer:
        return l10n.categoryComputer;

      case DeviceCategory.refrigerator:
        return l10n.categoryRefrigerator;

      case DeviceCategory.aircon:
        return l10n.categoryAirConditioner;

      case DeviceCategory.car:
        return l10n.categoryCar;

      case DeviceCategory.etc:
        return l10n.categoryOthers;
    }
  }
}

class _InfoCard extends StatelessWidget {
  final String title;

  final String value;

  final IconData icon;

  final VoidCallback? onTap;

  final Color? backgroundColor;

  final Color? foregroundColor;

  final Gradient? backgroundGradient;

  static const Gradient _defaultGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFBEE3F8),
      Color(0xFFC6F6D5),
    ],
  );

  const _InfoCard({
    required this.title,

    required this.value,

    required this.icon,

    this.onTap,

    this.backgroundColor,

    this.foregroundColor,

    this.backgroundGradient,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final effectiveForeground = foregroundColor;

    final titleStyle = effectiveForeground != null
        ? textTheme.labelMedium?.copyWith(color: effectiveForeground)
        : textTheme.labelMedium;

    final valueStyle = effectiveForeground != null
        ? textTheme.titleMedium?.copyWith(color: effectiveForeground)
        : textTheme.titleMedium;

    final iconColor =
        effectiveForeground ??
        theme.iconTheme.color ??
        theme.colorScheme.onSurface;

    final gradient =
        backgroundGradient ?? (backgroundColor == null ? _defaultGradient : null);
    final decoration = BoxDecoration(
      gradient: gradient,
      color: gradient == null ? backgroundColor ?? theme.cardColor : null,
    );

    return SizedBox(
      height: _menuItemExtent,

      child: Card(
        color: Colors.transparent,

        clipBehavior: Clip.antiAlias,

        child: InkWell(
          onTap: onTap,

          mouseCursor: onTap != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,

          child: Ink(
            decoration: decoration,
            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Row(
                children: [
                  Icon(
                    icon,
                    color: iconColor,
                    size: _menuItemExtent * 0.5,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(title, style: titleStyle),

                        const SizedBox(height: 4),

                        Text(value, style: valueStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhotoCarousel extends StatefulWidget {
  const _PhotoCarousel({required this.photos, required this.thumbnailSize});

  final List<String> photos;

  final double thumbnailSize;

  @override
  State<_PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<_PhotoCarousel> {
  late final PageController _controller;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    final rawFraction =
        (widget.thumbnailSize + 24) / (widget.thumbnailSize + 160);

    final viewportFraction = rawFraction < 0.3
        ? 0.3
        : (rawFraction > 1.0 ? 1.0 : rawFraction);

    _controller = PageController(viewportFraction: viewportFraction);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.photos.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        SizedBox(
          height: widget.thumbnailSize,

          child: PageView.builder(
            controller: _controller,

            padEnds: widget.photos.length == 1,

            onPageChanged: (index) => setState(() => _currentIndex = index),

            itemCount: widget.photos.length,

            itemBuilder: (context, index) {
              final path = widget.photos[index];

              final heroTag = _photoHeroTag(path, index);

              return Align(
                alignment: Alignment.centerLeft,

                child: Padding(
                  padding: EdgeInsets.only(
                    right: index == widget.photos.length - 1 ? 0 : 12,
                  ),

                  child: _Thumbnail(
                    path: path,

                    size: widget.thumbnailSize,

                    heroTag: heroTag,

                    onTap: () => _openFullScreen(index),
                  ),
                ),
              );
            },
          ),
        ),

        if (widget.photos.length > 1) ...[
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              for (var i = 0; i < widget.photos.length; i++)
                Container(
                  width: 8,

                  height: 8,

                  margin: const EdgeInsets.symmetric(horizontal: 4),

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: i == _currentIndex
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }

  void _openFullScreen(int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _FullScreenGallery(
          photos: widget.photos,

          initialIndex: initialIndex,
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({
    required this.path,

    required this.size,

    required this.heroTag,

    required this.onTap,
  });

  final String path;

  final double size;

  final Object heroTag;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final file = File(path);

    final placeholderColor = Theme.of(
      context,
    ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.6);

    return GestureDetector(
      onTap: onTap,

      child: Hero(
        tag: heroTag,

        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),

          child: DecoratedBox(
            decoration: BoxDecoration(color: placeholderColor),

            child: SizedBox.square(
              dimension: size,

              child: Image.file(
                file,

                fit: BoxFit.cover,

                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.broken_image_outlined,

                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FullScreenGallery extends StatefulWidget {
  const _FullScreenGallery({required this.photos, required this.initialIndex});

  final List<String> photos;

  final int initialIndex;

  @override
  State<_FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<_FullScreenGallery> {
  late final PageController _controller;

  late int _currentIndex;

  @override
  void initState() {
    super.initState();

    final initial = widget.initialIndex.clamp(0, widget.photos.length - 1);

    _currentIndex = initial;

    _controller = PageController(initialPage: initial);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: PageView.builder(
        controller: _controller,

        onPageChanged: (index) => setState(() => _currentIndex = index),

        itemCount: widget.photos.length,

        itemBuilder: (context, index) {
          final path = widget.photos[index];

          final file = File(path);

          return Center(
            child: Hero(
              tag: _photoHeroTag(path, index),

              child: InteractiveViewer(
                maxScale: 4,

                child: Image.file(
                  file,

                  fit: BoxFit.contain,

                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image_outlined,

                    size: 120,

                    color: Colors.white54,
                  ),
                ),
              ),
            ),
          );
        },
        ),
      ),
    );
  }
}

String _photoHeroTag(String path, int index) =>
    'device-photo-$index-${path.hashCode}';
