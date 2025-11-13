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
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: _searchQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final repo = context.watch<DeviceRepository>();
    final categories = _CategoryDefinition.values;
    final devices = repo.devices.toList(growable: false);
    final filteredDevices = _searchQuery.isEmpty
        ? const <Device>[]
        : _filterDevices(devices, _searchQuery);

    return ResponsiveScaffold(
      bottomNavigationBar: _BottomSearchBar(
        controller: _searchController,
        hintText: l10n.homeSearchHint,
        onChanged: _onSearchChanged,
        onVoiceInput: () => _startVoiceInput(context),
      ),
      builder: (context, layout) {
        final topInset = MediaQuery.of(context).padding.top;

        final contentChildren = <Widget>[
          const SizedBox(height: 12),
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
          contentChildren.addAll([
            Align(
              alignment: Alignment.centerLeft,
              child: InputChip(
                avatar: const Icon(Icons.search, size: 18),
                label: Text('${l10n.homeSearchHint}: $_searchQuery'),
                onDeleted: () => setState(() {
                  _searchQuery = '';
                  _searchController.clear();
                }),
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
                      width: DeviceGridCard.widthForLayout(layout),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: DeviceGridCard(
                          device: device,
                          monthsRemaining: repo.monthsRemaining(device),
                          onTap: () => context.push('/device/${device.id}'),
                        ),
                      ),
                    ),
                ],
              ),
            const SizedBox(height: 24),
          ]);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                icon: const Icon(Icons.settings),
                onPressed: () => context.push('/settings'),
                tooltip: l10n.homeSettingsTooltip,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: topInset),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: contentChildren,
              ),
            ),
          ],
        );
      },
    );
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  void _startVoiceInput(BuildContext context) {
    // TODO(voice): integrate voice input handler when available.
    FocusScope.of(context).unfocus();
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
    const iconGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF5CA7E3), Color(0xFF6AC48A)],
    );
    const iconColor = Colors.white;
    final columnCount = layout.isDesktop
        ? 4
        : layout.isTablet
        ? 3
        : 2;
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
    final iconSize = (avatarExtent * 0.69).clamp(0, avatarExtent).toDouble();

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
                        gradient: iconGradient,
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

class _BottomSearchBar extends StatelessWidget {
  const _BottomSearchBar({
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.onVoiceInput,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback onVoiceInput;

  static const double _tabletBreakpoint = 600;
  static const double _desktopBreakpoint = 1024;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final horizontalPadding = width >= _desktopBreakpoint
        ? 32.0
        : width >= _tabletBreakpoint
        ? 24.0
        : 16.0;

    return SafeArea(
      top: false,
      child: Material(
        color: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            12,
            horizontalPadding,
            12,
          ),
          child: SizedBox(
            height: 60,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: hintText,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: onVoiceInput,
                  tooltip: MaterialLocalizations.of(context).searchFieldLabel,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
