import 'package:flutter/material.dart';
import 'package:todoapp_cubit/states/tag_state.dart';
import 'package:todoapp_cubit/states/task_state.dart';
import 'add_tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_cubit/blocs/tasks_cubit.dart';
import 'package:todoapp_cubit/blocs/tags_cubit.dart';
import 'package:todoapp_cubit/blocs/login_cubit.dart';
import 'package:todoapp_cubit/dto/tag.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  TaskFormState createState() => TaskFormState();
}

class TaskFormState extends State<TaskForm> {
  final formKey = GlobalKey<FormState>();
  DateTime dueDate = DateTime.now();
  String taskName = '';

  @override
  Widget build(BuildContext context) {
    void submitForm() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        String authToken =
            BlocProvider.of<LoginCubit>(context).state.user.authToken!;
        List<Tag> tags = BlocProvider.of<TasksCubit>(context).state.tags;
        List<int> labelIds = tags.map((e) => e.id).toList();
        if (tags.isNotEmpty) {
          BlocProvider.of<TasksCubit>(context).addTask(
            authToken,
            taskName,
            dueDate,
            labelIds,
          );
          BlocProvider.of<TasksCubit>(context).deleteTags();
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Debe seleccionar al menos una etiqueta'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Tarea'),
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
                  labelText: 'Nombre de tarea',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Porfavor ingresar un nombre de tarea';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    taskName = value!;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  const Text('Fecha de vencimiento: '),
                  TextButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: dueDate,
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 3650)),
                        lastDate:
                            DateTime.now().add(const Duration(days: 3650)),
                        locale: const Locale('es', ''),
                      );
                      if (date != null) {
                        setState(() {
                          dueDate = date;
                        });
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
                          value: state.tags.isEmpty
                              ? 'No existen etiquetas'
                              : state.tags[state.selectedTag],
                          hint: const Text('Selecciona una etiqueta'),
                          items: state.tags.map((tag) {
                            return DropdownMenuItem(
                              value: tag,
                              child: Text(tag.text),
                            );
                          }).toList(),
                          onChanged: (value) {
                            BlocProvider.of<TagsCubit>(context)
                                .selectTag(state.tags.indexOf(value as Tag));
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  IconButton(
                    tooltip: 'Seleccionar etiqueta',
                    color: Colors.blue,
                    onPressed: () {
                      Tag selectedTag =
                          BlocProvider.of<TagsCubit>(context).state.tags[
                              BlocProvider.of<TagsCubit>(context)
                                  .state
                                  .selectedTag];
                      BlocProvider.of<TasksCubit>(context).addTag(selectedTag);
                    },
                    icon: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 16.0),
                  IconButton(
                    tooltip: 'Agregar o editar etiquetas',
                    color: Colors.blue,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddTag())),
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
              //Show all selected tags
              const SizedBox(height: 32.0),
              Column(
                children: <Widget>[
                  const Text('Etiquetas seleccionadas: '),
                  BlocBuilder<TasksCubit, TaskState>(
                    /*buildWhen: (previous, current) {
                      return previous.tags != current.tags ;
                    },*/
                    builder: (context, state) {
                      return Wrap(
                        direction: Axis.vertical,
                        spacing: 8.0,
                        children: state.tags.map((tag) {
                          return Chip(
                            label: Text(tag.text),
                            onDeleted: () {
                              BlocProvider.of<TasksCubit>(context)
                                  .removeTag(tag);
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: submitForm,
                    child: const Text('Agregar Tarea'),
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
