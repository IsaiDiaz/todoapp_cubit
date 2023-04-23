import 'package:flutter/material.dart';
import 'package:todoapp_cubit/dto/tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_cubit/blocs/tags_cubit.dart';
import 'package:todoapp_cubit/states/tag_state.dart';
import 'package:todoapp_cubit/dto/tag.dart';

class AddTag extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagsCubit, TagState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Mi lista'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: state.temporalTags.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: TextField(
                        decoration: InputDecoration(
                          labelText: state.temporalTags[index].text,
                        ),
                        controller: TextEditingController(text: state.temporalTags[index].text),
                        onSubmitted: (value) {
                          context.read<TagsCubit>().updateTemporalTag(state.temporalTags[index], value);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<TagsCubit>().removeTemporalTag(state.temporalTags[index]);
                        },
                      ),
                    ),
                    Divider(),
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
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    // Acción para cancelar
                    BlocProvider.of<TagsCubit>(context).cancelTemporalTags();
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    // Acción para guardar
                    BlocProvider.of<TagsCubit>(context).saveTags();
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  onPressed: () {
                    context.read<TagsCubit>().addTemporalTag(Tag(text: ''));
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}