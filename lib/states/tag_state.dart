import 'package:todoapp_cubit/dto/tag.dart';

class TagState {
  final List<Tag> tags;
  final List<Tag> temporalTags;
  final int selectedTag;

  TagState({this.tags = const [], this.selectedTag = 0, this.temporalTags = const []});

  TagState copyWith({List<Tag>? tags, int? selectedTag, List<Tag>? temporalTags}) {
    return TagState(
      tags: tags ?? this.tags,
      selectedTag: selectedTag ?? this.selectedTag,
      temporalTags: temporalTags ?? this.temporalTags,
    );
  }
}