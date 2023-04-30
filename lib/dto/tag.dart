import 'package:equatable/equatable.dart';

class Tag extends Equatable{
  final int id;
  final String text;
  const Tag({required this.text,required this.id});

  Tag copyWith({String? text, int? id}) => Tag(text: text ?? this.text, id: id ?? this.id);

  @override
  List<Object?> get props => [id];
}