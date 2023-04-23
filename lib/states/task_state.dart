import 'package:todoapp_cubit/dto/task.dart';

class TaskState {
  final List<Task> tasks;

  TaskState({this.tasks = const []});

  TaskState copyWith({List<Task>? tasks}) {
    return TaskState(tasks: tasks ?? this.tasks);
  }
}