import 'package:flutter/material.dart';
import 'add_task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_cubit/blocs/tasks_cubit.dart';
import 'package:todoapp_cubit/states/task_state.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color completedColor = Colors.green;
    Color pendingColor = Colors.red;

    return BlocBuilder<TasksCubit, TaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Lista de tareas'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      iconColor: MaterialStateProperty.all(Colors.black),  
                      shape: MaterialStateProperty.all(
                        ContinuousRectangleBorder(
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                    ),
                    onPressed: () =>
                     Navigator.push(context, MaterialPageRoute(builder: (context) => const TaskForm())),
                    child: const Icon(Icons.add)),
                ),
          
                for (var task in state.tasks)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: task.isCompleted ? completedColor : pendingColor,
                          width: 1.0,
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            task.title,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            task.dueDate,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            task.tag.text,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            task.description,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            task.isCompleted ? 'Completado' : 'Pendiente',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                onPressed: () => context.read<TasksCubit>().toogleTask(task),
                                icon: Icon(
                                  task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
                                  color: task.isCompleted ? completedColor : pendingColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () => context.read<TasksCubit>().removeTask(task),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(209, 244, 67, 54),
                                ),
                              ),
                            ],
                          )                          
                        ],
                      )
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}