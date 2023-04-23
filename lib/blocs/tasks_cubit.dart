import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_cubit/states/task_state.dart';
import 'package:todoapp_cubit/dto/task.dart';

class TasksCubit extends Cubit<TaskState> {
  TasksCubit() : super(TaskState());

  void addTask(Task task) {
    emit(state.copyWith(tasks: [...state.tasks, task]));
  }

  void removeTask(Task task) {
    emit(state.copyWith(tasks: state.tasks..remove(task)));
  }

}