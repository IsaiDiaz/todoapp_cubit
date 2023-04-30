import 'package:todoapp_cubit/dto/task.dart';
import 'package:todoapp_cubit/dto/tag.dart';

class TaskState {
  final List<Task> tasks;
  final List<Tag> tags;
  final String requestStatus;

  TaskState(
      {this.tasks = const [],
      this.tags = const [],
      this.requestStatus = 'none'});

  TaskState copyWith(
      {List<Task>? tasks, List<Tag>? tags, String? requestStatus}) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      tags: tags ?? this.tags,
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }
}
