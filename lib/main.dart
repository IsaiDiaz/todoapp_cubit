import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_cubit/blocs/tasks_cubit.dart';
import 'package:todoapp_cubit/blocs/tags_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksCubit()),
        BlocProvider(create: (context) => TagsCubit()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}
