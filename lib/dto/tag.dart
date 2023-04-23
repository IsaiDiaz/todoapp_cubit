import 'package:equatable/equatable.dart';

class Tag extends Equatable{
  String text;
  Tag({required this.text});

  @override
  List<Object?> get props => [text];
}