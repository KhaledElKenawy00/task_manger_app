import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:taskmangerapp/models/task.dart';
import 'package:taskmangerapp/providers/task_provider.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('TaskProvider', () {
    test('fetchTasks returns tasks if the http call completes successfully',
        () async {
      final client = MockClient();
      final taskProvider = TaskProvider();

      when(client.get(Uri.parse('https://dummyjson.com/todos?limit=10&skip=0')))
          .thenAnswer((_) async => http.Response(
              '{"todos": [{"id": 1, "title": "Test", "completed": false}]}',
              200));

      await taskProvider.fetchTasks();

      expect(taskProvider.tasks, isA<List<Task>>());
      expect(taskProvider.tasks.length, 1);
    });

    test('addTask adds a task to the list', () async {
      final client = MockClient();
      final taskProvider = TaskProvider();

      when(client.post(Uri.parse('https://dummyjson.com/todos/add'),
              headers: {'Content-Type': 'application/json'},
              body: json.encode({'title': 'New Task', 'completed': false})))
          .thenAnswer((_) async => http.Response(
              '{"id": 2, "title": "New Task", "completed": false}', 200));

      await taskProvider.addTask('New Task');

      expect(taskProvider.tasks, isA<List<Task>>());
      expect(taskProvider.tasks.length, 1);
    });
  });
}
