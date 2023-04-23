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

  void toogleTask(Task task) {
    int toogledTaskIndex = state.tasks.indexOf(task);
    state.tasks[toogledTaskIndex] = task.copyWith(isCompleted: !task.isCompleted);
    emit(state.copyWith(tasks: state.tasks));
  }

}