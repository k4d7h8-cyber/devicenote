import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:devicenote/data/repositories/device_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeviceNote'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
            tooltip: '설정',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: '검색',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Consumer<DeviceRepository>(
                  builder: (context, repo, _) {
                    final items = repo.devices;
                    if (items.isEmpty) {
                      return const Center(child: Text('등록된 기기가 없습니다.'));
                    }
                    return ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final d = items[index];
                        final remain = repo.monthsRemaining(d);
                        return ListTile(
                          title: Text(d.name),
                          subtitle: Text('${d.brand} • ${d.model}'),
                          trailing: Text('D${remain == 0 ? '-day' : '-$remain m'}'),
                          onTap: () => context.push('/device/${d.id}'),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/device/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

