import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: task.title);
    return Scaffold(
      appBar: AppBar(title: Text('Task Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SwitchListTile(
              title: Text('Completed'),
              value: task.completed,
              onChanged: (value) {
                // Update task completed state
              },
            ),
            ElevatedButton(
              onPressed: () {
                final updatedTask = Task(
                  id: task.id,
                  title: titleController.text,
                  completed: task.completed,
                );
                Provider.of<TaskProvider>(context, listen: false)
                    .updateTask(updatedTask);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
