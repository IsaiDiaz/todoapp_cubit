import 'tag.dart';
import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String title;
  final String description;
  final String dueDate;
  final bool isCompleted;
  final Tag tag;

  const Task({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
    required this.tag,
  });

  Task copyWith({
    String? title,
    String? description,
    String? dueDate,
    bool? isCompleted,
    Tag? tag,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      tag: tag ?? this.tag,
    );
  }

  @override
  List<Object?> get props => [title, description, dueDate, isCompleted, tag];
}