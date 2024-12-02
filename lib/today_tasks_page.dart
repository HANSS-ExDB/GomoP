import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_task_provider.dart'; // 위에서 정의한 파일 import

class TodayTasksPage extends ConsumerWidget {
  final String userEmail;

  TodayTasksPage({required this.userEmail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Firebase 데이터 스트림 구독
    final taskStream = ref.watch(taskStreamProvider(userEmail));

    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 할 일'),
      ),
      body: taskStream.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return Center(child: Text('오늘의 할 일이 없습니다.'));
          }
          return ListView(
            children: tasks.entries.map((entry) {
              final time = entry.key;
              final task = entry.value;
              return ListTile(
                title: Text('$time: $task'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    ref.read(firebaseTaskServiceProvider).deleteTask(
                      userEmail,
                      DateTime.now().toIso8601String().split('T').first,
                      time,
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('에러 발생: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(firebaseTaskServiceProvider).addTask(
            userEmail,
            DateTime.now().toIso8601String().split('T').first,
            '20:00',
            '새로운 할 일',
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
