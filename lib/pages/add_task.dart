import 'package:flutter/material.dart';
import 'package:todoapp_cubit/states/tag_state.dart';
import 'add_tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_cubit/blocs/tasks_cubit.dart';
import 'package:todoapp_cubit/blocs/tags_cubit.dart';
import 'package:todoapp_cubit/dto/task.dart';
import 'package:todoapp_cubit/dto/tag.dart';

class TaskForm extends StatelessWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final tagsController = TextEditingController();

    String taskName = '';
    DateTime dueDate = DateTime.now();

    void submitForm() {
      if (formKey.currentState!.validate()) {
        // Form is valid, do something with the data
        formKey.currentState!.save();
        int selectTag = BlocProvider.of<TagsCubit>(context).state.selectedTag;
        final task = Task(
          title: taskName,
          description: "Descripcion",
          isCompleted: false,
          dueDate: dueDate,
          tag: BlocProvider.of<TagsCubit>(context).state.tags[selectTag],
        );
        BlocProvider.of<TasksCubit>(context).addTask(task);
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
                onSaved: (value) {
                  taskName = value!;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  const Text('Due Date: '),
                  TextButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: dueDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        dueDate = date;
                      }
                    },
                    child: Text(
                      '${dueDate.day}/${dueDate.month}/${dueDate.year}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: BlocBuilder<TagsCubit, TagState>(
                      builder: (context, state) {
                        return DropdownButtonFormField(
                          value: state.tags.isEmpty ? null : state.tags[state.selectedTag],
                          hint: const Text('Select a tag'),
                          items: state.tags.map((tag) {
                            return DropdownMenuItem(
                              value: tag,
                              child: Text(tag.text),
                            );
                          }).toList(),
                          onChanged: (value) {
                            BlocProvider.of<TagsCubit>(context).selectTag(state.tags.indexOf(value as Tag));
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddTag())),
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
              //Show all selected tags
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: submitForm,
                    child: Text('Add Task'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
