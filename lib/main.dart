import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_cubit/blocs/tasks_cubit.dart';
import 'package:todoapp_cubit/blocs/tags_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todoapp_cubit/blocs/login_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksCubit()),
        BlocProvider(create: (context) => TagsCubit()),
        BlocProvider(create: (context) => LoginCubit()),
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      home: Login(),
    );
  }
}
