import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_cubit/states/tag_state.dart';
import 'package:todoapp_cubit/dto/tag.dart';
import 'package:todoapp_cubit/service/labels_api.dart';
import 'dart:convert';

class TagsCubit extends Cubit<TagState> {
  TagsCubit() : super(TagState());

  void getTags(String authToken) async {
    emit(state.copyWith(tags: List.empty(), selectedTag: null, requestStatus: 'loading'));
    final httpResponse = await LabelsApi.getLabels(authToken);
    if (httpResponse.statusCode == 200) {
      final jsonData = json.decode(httpResponse.body);
      if (jsonData['code'] == '0000') {
        final response = jsonData['response'];
        for (var item in response) {
          Tag tag = Tag(text: item['name'], id: item['labelId']);
          addTag(tag);
        }
        emit(state.copyWith(requestStatus: 'success'));
      } else {
        emit(state.copyWith(requestStatus: 'error ${jsonData['code']}'));
      }
    } else {
      emit(state.copyWith(requestStatus: 'error ${httpResponse.statusCode}'));
    }
  }

  static Future<Tag> getOneTag(String authToken, int id) async {
    final httpResponse = await LabelsApi.getLabel(authToken, id);
    Tag tag = const Tag(text: 'Error buscando esta etiqueta', id: 0);
    if (httpResponse.statusCode == 200) {
      final jsonData = json.decode(httpResponse.body);
      if (jsonData['code'] == '0000') {
        final response = jsonData['response'];
        tag = Tag(text: response['name'], id: response['labelId']);
        return tag;
      }
    }
    return tag;
  }

  void postTag(String name, DateTime date, String authToken) async {
    emit(state.copyWith(requestStatus: 'loading'));
    final httpResponse = await LabelsApi.postLabel(name, date, authToken);
    if (httpResponse.statusCode == 200) {
      final jsonData = json.decode(httpResponse.body);
      if (jsonData['code'] == '0000') {
        emit(state.copyWith(requestStatus: 'success'));
      } else {
        emit(state.copyWith(requestStatus: 'error ${jsonData['code']}'));
      }
    } else {
      emit(state.copyWith(requestStatus: 'error ${httpResponse.statusCode}'));
    }
  }

  void updateTag(String text, DateTime date, String authToken, int id) async {
    emit(state.copyWith(requestStatus: 'loading'));
    final httpResponse = await LabelsApi.updateLabel(text, date, authToken, id);
    if (httpResponse.statusCode == 200) {
      final jsonData = json.decode(httpResponse.body);
      if (jsonData['code'] == '0000') {
        emit(state.copyWith(requestStatus: 'success'));
      } else {
        emit(state.copyWith(requestStatus: 'error ${jsonData['code']}'));
      }
    }else{
      emit(state.copyWith(requestStatus: 'error ${httpResponse.statusCode}'));
    }
  }

  void deleteTag(String authToken, int id) async {
    emit(state.copyWith(requestStatus: 'loading'));
    final httpResponse = await LabelsApi.deleteLabel(id, authToken);
    if (httpResponse.statusCode == 200) {
      final jsonData = json.decode(httpResponse.body);
      if (jsonData['code'] == '0000') {
        emit(state.copyWith(requestStatus: 'success'));
      } else {
        emit(state.copyWith(requestStatus: 'error ${jsonData['code']}'));
      }
    }else{
      emit(state.copyWith(requestStatus: 'error ${httpResponse.statusCode}'));
    }
  }

  void addTag(Tag tag) {
    emit(state.copyWith(
        tags: [...state.tags, tag], temporalTags: [...state.tags, tag]));
  }

  void removeTag(Tag tag) {
    emit(state.copyWith(
        tags: state.tags..remove(tag), temporalTags: state.tags..remove(tag)));
  }

  void selectTag(int index) {
    emit(state.copyWith(selectedTag: index));
  }

  void addTemporalTag(Tag tag) {
    emit(state.copyWith(temporalTags: [...state.temporalTags, tag]));
  }

  void removeTemporalTag(Tag tag) {
    emit(state.copyWith(temporalTags: state.temporalTags..remove(tag)));
  }

  void updateTemporalTag(Tag tag, String text) {
    int updatedTagindex = state.temporalTags.indexOf(tag);
    state.temporalTags[updatedTagindex] = tag.copyWith(text: text);
    emit(state.copyWith(temporalTags: state.temporalTags));
  }

  void saveTags(String authToken) {
    emit(state.copyWith(requestStatus: 'loading'));
    List<Tag> newTags = state.temporalTags
        .where((element) => !state.tags.contains(element))
        .toList();
    List<Tag> editedTags = state.temporalTags
        .where((element) => state.tags.contains(element))
        .toList();
    List<Tag> deletedTags = state.tags
        .where((element) => !state.temporalTags.contains(element))
        .toList();
    //Eliminar etiquetas eliminadas del servidor
    for (var tag in deletedTags) {
      deleteTag(authToken, tag.id);
    }
    //Agregar etiquetas nuevas al servidor
    for (var tag in newTags) {
      postTag(tag.text, DateTime.now(), authToken);
    }
    //Actualizar etiquetas editadas en el servidor
    for (var tag in editedTags) {
      updateTag(tag.text, DateTime.now(), authToken, tag.id);
    }


    getTags(authToken);
  }

  void cancelTemporalTags() {
    emit(state.copyWith(temporalTags: state.tags));
  }
}
