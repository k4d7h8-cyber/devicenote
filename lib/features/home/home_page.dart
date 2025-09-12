import 'package:flutter/material.dart';
import 'package:devicenote/features/device/add_device_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeviceNote'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: '검색창',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.sort),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      hint: const Text('정렬 필터'),
                      items: const [
                        DropdownMenuItem(
                          value: 'latest',
                          child: Text('최신순'),
                        ),
                        DropdownMenuItem(
                          value: 'name',
                          child: Text('이름순'),
                        ),
                      ],
                      onChanged: (_) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Expanded(
                child: Center(
                  child: Text('여기에 제품 리스트가 표시됩니다.'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddDevicePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
