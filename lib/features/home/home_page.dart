import 'dart:math' as math;

import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/responsive_layout.dart';
import 'package:devicenote/utils/category_display.dart';
import 'package:devicenote/features/home/widgets/device_grid_card.dart';
import 'package:flutter/material.dart';
import 'package:devicenote/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final repo = context.watch<DeviceRepository>();
    final categories = _CategoryDefinition.values;
    final devices = repo.devices.toList(growable: false);
    final filteredDevices =
        _searchQuery.isEmpty ? const <Device>[] : _filterDevices(devices, _searchQuery);

    return ResponsiveScaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: l10n.homeSearchHint,
            onPressed: devices.isEmpty ? null : () => _startSearch(l10n, devices),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
            tooltip: l10n.homeSettingsTooltip,
          ),
        ],
      ),
      builder: (context, layout) {
        final children = <Widget>[
          const SizedBox(height: 24),
          _CategoryGrid(
            categories: categories,
            layout: layout,
            onTap: _openCategory,
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.center,
            child: Text(
              homeCategoryPrompt(l10n),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 24),
        ];

        if (_searchQuery.isNotEmpty) {
          children.addAll([
            Align(
              alignment: Alignment.centerLeft,
              child: InputChip(
                avatar: const Icon(Icons.search, size: 18),
                label: Text('${l10n.homeSearchHint}: $_searchQuery'),
                onDeleted: () => setState(() => _searchQuery = ''),
              ),
            ),
            const SizedBox(height: 12),
            if (filteredDevices.isEmpty)
              SizedBox(
                height: 160,
                child: Center(
                  child: Text(
                    searchNoResultsMessage(l10n),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
            else
              Wrap(
                spacing: layout.gutter,
                runSpacing: layout.gutter,
                children: [
                  for (final device in filteredDevices)
                    SizedBox(
                      width: layout.columnWidth(),
                      child: DeviceGridCard(
                        device: device,
                        monthsRemaining: repo.monthsRemaining(device),
                        onTap: () => context.push('/device/${device.id}'),
                      ),
                    ),
                ],
              ),
            const SizedBox(height: 24),
          ]);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        );
      },
    );
  }

  Future<void> _startSearch(AppLocalizations l10n, List<Device> devices) async {
    final delegate = _DeviceSearchDelegate(
      devices: devices,
      l10n: l10n,
      initialQuery: _searchQuery,
    );
    final selected = await showSearch<Device?>(
      context: context,
      delegate: delegate,
    );
    if (!mounted) return;
    setState(() {
      _searchQuery = delegate.query.trim();
    });
    if (selected != null) {
      if (!mounted) return;
      context.push('/device/${selected.id}');
    }
  }

  void _openCategory(DeviceCategory category) {
    context.push('/category/${category.name}');
  }

  List<Device> _filterDevices(List<Device> devices, String query) {
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) {
      return devices;
    }
    return devices
        .where((device) => _matchesQuery(device, needle))
        .toList(growable: false);
  }

  bool _matchesQuery(Device device, String needle) {
    return device.name.toLowerCase().contains(needle) ||
        device.brand.toLowerCase().contains(needle) ||
        device.model.toLowerCase().contains(needle);
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({
    required this.categories,
    required this.layout,
    required this.onTap,
  });

  final List<_CategoryDefinition> categories;
  final ResponsiveLayoutInfo layout;
  final ValueChanged<DeviceCategory> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    const iconBackground = Color(0xFF4A90E2);
    const iconColor = Colors.white;
    final columnCount = layout.isDesktop ? 4 : layout.isTablet ? 3 : 2;
    final spacing = layout.gutter;
    final contentWidth = layout.contentWidth;
    final rawTileWidth = columnCount > 1
        ? (contentWidth - spacing * (columnCount - 1)) / columnCount
        : contentWidth;
    final fallbackWidth = contentWidth > 0 ? contentWidth : 160.0;
    final effectiveTileWidth = rawTileWidth.isFinite && rawTileWidth > 0
        ? rawTileWidth
        : fallbackWidth;
    final avatarExtent = math.min(effectiveTileWidth, 160.0);
    final iconSize = math.min(90.0, avatarExtent * 0.6);

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: spacing,
      runSpacing: spacing,
      children: [
        for (final item in categories)
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: () => onTap(item.category),
              child: SizedBox(
                width: effectiveTileWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: avatarExtent,
                      height: avatarExtent,
                      decoration: BoxDecoration(
                        color: iconBackground,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      alignment: Alignment.center,
                      child: Icon(item.icon, size: iconSize, color: iconColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      categoryDisplayName(l10n, item.category),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _CategoryDefinition {
  const _CategoryDefinition(this.category);

  final DeviceCategory category;

  IconData get icon => categoryIcon(category);

  static List<_CategoryDefinition> get values => DeviceCategory.values
      .map((category) => _CategoryDefinition(category))
      .toList(growable: false);
}

class _DeviceSearchDelegate extends SearchDelegate<Device?> {
  _DeviceSearchDelegate({
    required this.devices,
    required this.l10n,
    String initialQuery = '',
  }) : super(searchFieldLabel: l10n.homeSearchHint) {
    query = initialQuery;
  }

  final List<Device> devices;
  final AppLocalizations l10n;

  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query.isEmpty) {
      return null;
    }
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);

  Widget _buildList(BuildContext context) {
    final results = _filter(query);
    if (results.isEmpty) {
      return Center(
        child: Text(
          searchNoResultsMessage(l10n),
          style: const TextStyle(fontSize: 16),
        ),
      );
    }
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (_, __) => const Divider(height: 0),
      itemBuilder: (context, index) {
        final device = results[index];
        return ListTile(
          leading: const Icon(Icons.devices_outlined),
          title: Text(device.name),
          subtitle: Text('${device.brand} · ${device.model}'),
          onTap: () => close(context, device),
        );
      },
    );
  }

  List<Device> _filter(String rawQuery) {
    final needle = rawQuery.trim().toLowerCase();
    if (needle.isEmpty) {
      return devices;
    }
    return devices
        .where((device) => device.name.toLowerCase().contains(needle) ||
            device.brand.toLowerCase().contains(needle) ||
            device.model.toLowerCase().contains(needle))
        .toList(growable: false);
  }
}
