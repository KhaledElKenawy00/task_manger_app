import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  int _limit = 10;
  int _skip = 0;
  bool _hasMore = true;

  List<Task> get tasks => _tasks;
  bool get hasMore => _hasMore;

  Future<void> fetchTasks() async {
    if (!_hasMore) return;

    final url =
        Uri.parse('https://dummyjson.com/todos?limit=$_limit&skip=$_skip');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['todos'] as List;
      if (data.length < _limit) _hasMore = false;

      _tasks.addAll(data.map((json) => Task.fromJson(json)).toList());
      _skip += _limit;
      notifyListeners();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> addTask(String title) async {
    final url = Uri.parse('https://dummyjson.com/todos/add');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title, 'completed': false}),
    );

    if (response.statusCode == 200) {
      final task = Task.fromJson(json.decode(response.body));
      _tasks.add(task);
      notifyListeners();
    } else {
      throw Exception('Failed to add task');
    }
  }

  Future<void> updateTask(Task task) async {
    final url = Uri.parse('https://dummyjson.com/todos/${task.id}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode == 200) {
      final index = _tasks.indexWhere((t) => t.id == task.id);
      _tasks[index] = task;
      notifyListeners();
    } else {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int id) async {
    final url = Uri.parse('https://dummyjson.com/todos/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      _tasks.removeWhere((task) => task.id == id);
      notifyListeners();
    } else {
      throw Exception('Failed to delete task');
    }
  }
}
