import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_cubit/states/login_state.dart';
import 'package:todoapp_cubit/dto/user.dart';
import 'package:todoapp_cubit/service/auth_api.dart';
import 'dart:convert';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  Future<void> loginWithCredentials(String userName, String password) async {
    final httpResponse = await AuthApi.login(userName, password);
    bool isLogged = false;
    User user;
    if(httpResponse.statusCode == 200){
      final jsonData = json.decode(httpResponse.body);
      if(jsonData['code'] == '0000'){
         final response = jsonData['response'];
        user = User(authToken: response['authToken'], refreshToken: response['refreshToken'], userName: userName);
        isLogged = true;
      }else{
        user = const User();
      }
    }else{
      user = const User();
    }
    emit(state.copyWith(user: user, isLogged: isLogged, isLoading: false));
  }

  void loading() {
    emit(state.copyWith(isLoading: true));
  }

  void logout() {
    emit(state.copyWith(user: const User(), isLogged: false));
  }
}