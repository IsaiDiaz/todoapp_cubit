import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_cubit/states/tag_state.dart';
import 'package:todoapp_cubit/dto/tag.dart';

List<Tag> defaultTags = [
    Tag(text: 'All'),
    Tag(text: 'Work'),
    Tag(text: 'Home'),
    Tag(text: 'Personal'),
  ];

class TagsCubit extends Cubit<TagState> {
  TagsCubit() : super(TagState(tags: defaultTags, temporalTags: defaultTags));

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
    state.temporalTags[updatedTagindex].text = text;
    emit(state.copyWith(temporalTags: state.temporalTags));
  }

  void saveTags(){
    emit(state.copyWith(tags: state.temporalTags));
  }

  void cancelTemporalTags(){
    emit(state.copyWith(temporalTags: state.tags));
  }

}