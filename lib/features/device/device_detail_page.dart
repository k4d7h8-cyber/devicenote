import 'dart:io';
import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

const double _menuItemExtent = 104;

class DeviceDetailPage extends StatelessWidget {
  final String id;
  const DeviceDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<DeviceRepository>();
    final device = repo.findById(id);

    if (device == null) {
      return ResponsiveScaffold(
        appBar: AppBar(title: const Text('상세')),
        builder: (context, layout) =>
            const Center(child: Text('기기를 찾을 수 없습니다.')),
      );
    }

    final dateFmt = DateFormat('yyyy-MM-dd');

    return ResponsiveScaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: '수정',
            onPressed: () => context.push('/device/${device.id}/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: '삭제',
            onPressed: () => _confirmDelete(context, repo, device.id),
          ),
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            tooltip: '엑셀 내보내기',
            onPressed: () {
              // TODO: Implement Excel export
            },
          ),
        ],
      ),
      builder: (context, layout) {
        final cardWidth = layout.columnWidth();
        final cards = [
          _InfoCard(
            title: 'Category',
            value: _categoryLabel(device.category),
            icon: Icons.category,
          ),
          _InfoCard(
            title: 'Brand',
            value: device.brand,
            icon: Icons.storefront,
          ),
          _InfoCard(
            title: 'Model Name',
            value: device.name,
            icon: Icons.devices,
          ),
          _InfoCard(
            title: 'Model No.',
            value: device.model,
            icon: Icons.confirmation_number,
          ),
          _InfoCard(
            title: 'Purchase Date',
            value: dateFmt.format(device.purchaseDate),
            icon: Icons.event,
          ),
          _InfoCard(
            title: 'Warranty (months)',
            value: device.warrantyMonths.toString(),
            icon: Icons.verified_user,
          ),
          _InfoCard(
            title: 'Customer Center',
            value: device.asContact ?? '-',
            icon: Icons.phone,
          ),
        ];

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
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/device/${device.id}/edit'),
                    icon: const Icon(Icons.edit),
                    label: const Text('수정'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _confirmDelete(context, repo, device.id),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('삭제'),
                  ),
                ),
              ],
            ),
            if (device.imagePaths.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text('Photos', style: Theme.of(context).textTheme.titleMedium),
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

  Future<void> _confirmDelete(
    BuildContext context,
    DeviceRepository repo,
    String id,
  ) async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete this device?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (yes == true) {
      repo.remove(id);
      if (context.mounted) context.pop();
    }
  }

  String _categoryLabel(DeviceCategory c) {
    switch (c) {
      case DeviceCategory.tv:
        return 'TV';
      case DeviceCategory.washer:
        return '세탁기';
      case DeviceCategory.computer:
        return '컴퓨터';
      case DeviceCategory.refrigerator:
        return '냉장고';
      case DeviceCategory.aircon:
        return '에어컨';
      case DeviceCategory.car:
        return '자동차';
      case DeviceCategory.etc:
        return '기타';
    }
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _menuItemExtent,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 4),
                    Text(value, style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
            ],
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('${_currentIndex + 1} / ${widget.photos.length}'),
      ),
      body: PageView.builder(
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
    );
  }
}

String _photoHeroTag(String path, int index) =>
    'device-photo-$index-${path.hashCode}';
