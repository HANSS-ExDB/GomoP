import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';

// Firebase Database Service
class FirebaseTaskService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // 실시간 데이터 읽기
  Stream<Map<String, dynamic>> getTasks(String email) {
    final emailKey = email.replaceAll('.', '_'); // Firebase에서 '.'을 허용하지 않음
    return _database.child('tasks/$emailKey').onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      return Map<String, dynamic>.from(data);
    });
  }

  // 할 일 추가
  Future<void> addTask(String email, String date, String time, String task) async {
    final emailKey = email.replaceAll('.', '_');
    await _database.child('tasks/$emailKey/$date/$time').set(task);
  }

  // 할 일 삭제
  Future<void> deleteTask(String email, String date, String time) async {
    final emailKey = email.replaceAll('.', '_');
    await _database.child('tasks/$emailKey/$date/$time').remove();
  }
}

// FirebaseTaskService Provider (전역 서비스 제공)
final firebaseTaskServiceProvider = Provider((ref) => FirebaseTaskService());

// Firebase Task Stream Provider (실시간 데이터 스트림 제공)
final taskStreamProvider = StreamProvider.family<Map<String, dynamic>, String>((ref, email) {
  final service = ref.read(firebaseTaskServiceProvider);
  return service.getTasks(email);
});
