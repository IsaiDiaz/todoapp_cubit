import 'tag.dart';
import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;
  Tag tag;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
    required this.tag,
  });

  @override
  List<Object?> get props => [title, description, dueDate, isCompleted, tag];
}