// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_project/view/screens/To_do_splashscreen.dart';
import 'package:todo_project/core/Bloc_Observer.dart';
import 'package:todo_project/model_view/task_cubit_class.dart';

void main() async {
  Bloc.observer = MyBlocObserver(); // to display states on runtime
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit()..initDatabase(),
        ),
      ],
      child: MaterialApp(
        home: ToDosplashScreen(),
      ),
    );
  }
}
