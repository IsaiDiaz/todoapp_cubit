import 'tag.dart';
import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final int id;
  final String title;
  final String description;
  final String dueDate;
  final bool isCompleted;
  final List<Tag> tags;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
    required this.tags,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? dueDate,
    bool? isCompleted,
    List<Tag>? tags,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [id, title, description, dueDate, isCompleted, tags];
}