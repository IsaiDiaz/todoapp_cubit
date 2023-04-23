import 'package:flutter/material.dart';
import 'package:todoapp_cubit/dto/tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_cubit/blocs/tags_cubit.dart';
import 'package:todoapp_cubit/states/tag_state.dart';

class AddTag extends StatelessWidget {
  const AddTag({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagsCubit, TagState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Etiquetas'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: state.temporalTags.length,
              itemBuilder: (context, index) {
                final controller = TextEditingController(text: state.temporalTags[index].text);
                return Column(
                  children: [
                    ListTile(
                      title: TextField(
                        decoration: InputDecoration(
                          labelText: state.temporalTags[index].text,
                        ),                     
                        controller: controller,
                      ),
                      trailing: 
                      //Botones para guardar y eliminar las etiquetas
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'Guardar cambios en etiqueta  ${controller.text}',
                            color: Colors.green,
                            icon: const Icon(Icons.save),
                            onPressed: () {
                              // Acción para guardar
                              BlocProvider.of<TagsCubit>(context).updateTemporalTag(state.temporalTags[index], controller.text);
                            },
                          ),
                          IconButton(
                            tooltip: 'Eliminar etiqueta ${controller.text}',
                            color: Colors.red,
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Acción para eliminar
                              BlocProvider.of<TagsCubit>(context).removeTemporalTag(state.temporalTags[index]);
                            },
                          ),
                        ]
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  tooltip: 'Cancelar Cambios',
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    // Acción para cancelar
                    BlocProvider.of<TagsCubit>(context).cancelTemporalTags();
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  tooltip: 'Guardar Cambios',
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    // Acción para guardar
                    BlocProvider.of<TagsCubit>(context).saveTags();
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  tooltip: 'Agregar Etiqueta',
                  onPressed: () {
                    context.read<TagsCubit>().addTemporalTag(const Tag(text: ''));
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}