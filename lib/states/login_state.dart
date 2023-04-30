import 'package:todoapp_cubit/dto/user.dart';

class LoginState {
  final User user;
  final bool isLogged;
  final bool isLoading;

  LoginState(
      {this.user = const User(),
      this.isLogged = false,
      this.isLoading = false});

  LoginState copyWith({User? user, bool? isLogged, bool? isLoading}) {
    return LoginState(
      user: user ?? this.user,
      isLogged: isLogged ?? this.isLogged,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
