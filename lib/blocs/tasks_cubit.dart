import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_cubit/states/task_state.dart';
import 'package:todoapp_cubit/dto/task.dart';
import 'package:todoapp_cubit/blocs/tags_cubit.dart';
import 'package:todoapp_cubit/service/todo_api.dart';
import 'package:todoapp_cubit/dto/tag.dart';
import 'dart:convert';

class TasksCubit extends Cubit<TaskState> {
  TasksCubit() : super(TaskState());

  void getTasks (String authToken) async {
    final httpResponse = await TodoApi.getTasks(authToken);
    List<Task> tasks = [];
    emit(state.copyWith(requestStatus: 'loading'));
    if(httpResponse.statusCode == 200){
      final jsonData = json.decode(httpResponse.body);
      if(jsonData['code'] == '0000'){
        final response = jsonData['response'];
        for (var taskRes in response) {
          List<Tag> taskTags = [];
          for (int tag in taskRes['labelIds']) {
            Tag label = await TagsCubit.getOneTag(authToken, tag);
            taskTags.add(label);
          }
          Task task = Task(id: taskRes['taskId'], title: taskRes['description'], description: 'Descripcion', isCompleted: false, dueDate: taskRes['date'], tags: taskTags);
          tasks.add(task);
        }
      }
    }
    emit(state.copyWith(tasks: tasks, requestStatus: 'success'));
  }

  void addTag(Tag tag) {
    if(state.tags.contains(tag)){
      return;
    }
    emit(state.copyWith(tags: [...state.tags, tag]));
  }

  void removeTag(Tag tag) {
    emit(state.copyWith(tags: state.tags..remove(tag)));
  }

  void addTask(String authToken, String description, DateTime date,  List<int> labelIds) async {
    final httpResponse = await TodoApi.postTask(authToken, description, date, labelIds);
    emit(state.copyWith(requestStatus: 'loading'));
    if(httpResponse.statusCode == 200){
      final jsonData = json.decode(httpResponse.body);
      if(jsonData['code'] == '0000'){
        getTasks(authToken);
      }else{
        print('Error ${jsonData['code']}');
      }
    }else{
      print('Error ${httpResponse.statusCode}');
    }
    emit(state.copyWith(requestStatus: 'success'));
  }

  void removeTask(String authToken, Task task) async{
    final httpResponse = await TodoApi.deleteTask(authToken, task.id);
    emit(state.copyWith(requestStatus: 'loading'));
    if(httpResponse.statusCode == 200){
      final jsonData = json.decode(httpResponse.body);
      if(jsonData['code'] == '0000'){
        getTasks(authToken);
      }else{
        print('Error ${jsonData['code']}');
      }
    }
  }

  void toogleTask(Task task) {
    int toogledTaskIndex = state.tasks.indexOf(task);
    state.tasks[toogledTaskIndex] = task.copyWith(isCompleted: !task.isCompleted);
    emit(state.copyWith(tasks: state.tasks));
  }

  void deleteTags(){
    emit(state.copyWith(tags: []));
  }

}