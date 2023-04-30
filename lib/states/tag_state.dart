import 'package:todoapp_cubit/dto/tag.dart';

class TagState {
  final List<Tag> tags;
  final List<Tag> temporalTags;
  final int selectedTag;
  final bool isLoading;
  final String requestStatus;

  TagState(
      {this.tags = const [],
      this.selectedTag = 0,
      this.temporalTags = const [],
      this.isLoading = false,
      this.requestStatus = 'none'});

  TagState copyWith(
      {List<Tag>? tags,
      int? selectedTag,
      List<Tag>? temporalTags,
      bool? isLoading,
      String? requestStatus}) {
    return TagState(
      tags: tags ?? this.tags,
      selectedTag: selectedTag ?? this.selectedTag,
      temporalTags: temporalTags ?? this.temporalTags,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
