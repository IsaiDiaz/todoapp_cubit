import 'package:equatable/equatable.dart';

class Tag extends Equatable{
  final String text;
  const Tag({required this.text});

  Tag copyWith({String? text}) => Tag(text: text ?? this.text);

  @override
  List<Object?> get props => [text];
}