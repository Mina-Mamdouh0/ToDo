import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/bloc/blocobserver.dart';

import 'layout/homescreen.dart';

void main() {
  BlocOverrides.runZoned(
        () {},
    blocObserver: MyBlocObserver(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  HomeScreen(),
    );
  }
}
