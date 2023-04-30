import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_cubit/states/tag_state.dart';
import 'package:todoapp_cubit/dto/tag.dart';
import 'package:todoapp_cubit/service/labels_api.dart';
import 'dart:convert';

class TagsCubit extends Cubit<TagState> {
  TagsCubit() : super(TagState());

  void getTagsFromServer(String authToken) async {
    final httpResponse = await LabelsApi.getLabels(authToken);
    if (httpResponse.statusCode == 200) {
      final jsonData = json.decode(httpResponse.body);
      if (jsonData['code'] == '0000') {
        final response = jsonData['response'];
        for (var item in response) {
          Tag tag = Tag(text: item['name'], id: item['labelId']);
          addTag(tag);
        }
      }else{
        emit(state.copyWith(requestStatus: 'error'));
      }
    }else{
      emit(state.copyWith(requestStatus: 'error'));
    }
  }

  void getOneTag(String authToken, int id) async {
    final httpResponse = await LabelsApi.getLabel(authToken, id);
    if(httpResponse.statusCode == 200){
      final jsonData = json.decode(httpResponse.body);
      if(jsonData['code']=='0000'){
        final response = jsonData['response'];
        Tag tag = Tag(text: response['name'], id: response['labelId']);
      }else{
        emit(state.copyWith(requestStatus: 'error'));
      }
    }else{
      emit(state.copyWith(requestStatus: 'error'));
    }
  }

  void postTag(String authToken, Tag newTag)async{
    
  }

  void addTag(Tag tag) {
    emit(state.copyWith(tags: [...state.tags, tag], temporalTags: [...state.tags, tag]));
  }

  void removeTag(Tag tag) {
    emit(state.copyWith(tags: state.tags..remove(tag), temporalTags: state.tags..remove(tag)));
  }

  void selectTag(int index) {
    emit(state.copyWith(selectedTag: index));
  }

  void addTemporalTag(Tag tag) {
    emit(state.copyWith(temporalTags: [...state.temporalTags, tag]));
  }

  void removeTemporalTag(Tag tag){
    emit(state.copyWith(temporalTags: state.temporalTags..remove(tag)));
  }

  void updateTemporalTag(Tag tag, String text){
    int updatedTagindex = state.temporalTags.indexOf(tag);
    state.temporalTags[updatedTagindex] = tag.copyWith(text: text);
    emit(state.copyWith(temporalTags: state.temporalTags));
  }

  void saveTags(){
    emit(state.copyWith(tags: state.temporalTags));
  }

  void cancelTemporalTags(){
    emit(state.copyWith(temporalTags: state.tags));
  }

}