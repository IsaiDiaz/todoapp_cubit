import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String? userName;
  final String? authToken;
  final String? refreshToken;
  
  const User({this.userName,this.authToken,this.refreshToken});

  User copyWith({String? userName, String? authToken, String? refreshToken}) => User(userName: userName ?? this.userName, authToken: authToken ?? this.authToken, refreshToken: refreshToken ?? this.refreshToken);

  @override
  List<Object?> get props => [userName, authToken, refreshToken];

}