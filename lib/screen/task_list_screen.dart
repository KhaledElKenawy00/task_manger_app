import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: taskProvider.tasks.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: taskProvider.tasks.length + 1,
              itemBuilder: (ctx, i) {
                if (i == taskProvider.tasks.length) {
                  return taskProvider.hasMore
                      ? Center(child: CircularProgressIndicator())
                      : Container();
                }
                final task = taskProvider.tasks[i];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.completed ? 'Completed' : 'Pending'),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => TaskDetailScreen(task: task),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navigate to add task screen
        },
      ),
    );
  }
}
