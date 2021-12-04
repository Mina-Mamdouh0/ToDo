
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/screen/archivedscreen.dart';
import 'package:todo/screen/donescreen.dart';
import 'package:todo/screen/taskscreen.dart';
import 'package:todo/shared/bloc/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialAppState());

  static AppCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;
  IconData floShow=Icons.edit;
  Database? dataBase;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archiveTasks=[];
  bool isBottomSheetShown=false;

  List<Widget> screen =const [
    TaskScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];
  List title = [
    'Task',
    'Done',
    'Archived',
  ];

  void changeIndex(index){
    currentIndex=index;
    emit(ChangeNavBar());
  }

  void changeIconAndStateBottom({
  required IconData icon,
    required bool isBottomShown
}){
    isBottomSheetShown=isBottomShown;
    floShow=icon;
    emit(ChangeIconFloAndBottom());
  }

  void createDataBase()async{
    await openDatabase(
        'todo.dp',
        version: 1,
        onCreate: (dataBase,  version){
          print('dataBase Created');
          dataBase.execute(
              'CREATE TABLE Task (id INTEGER PRIMARY KEY, name TEXT, date TEXT, time TEXT, status TEXT)').then((value){
                print('table created');
          }).catchError((error){
            print('error on created table ${error.toString()}');});

        },
        onOpen: (dataBase){
          getDateFormDateBase(dataBase);
          print('dateBase Opening');
        }
    ).then((value){
      dataBase=value;
      emit(CreateDataBaseState());
    });
  }

   insertToDatabase({
    required String name,
    required String time,
    required String date,
  }) async{
    return await  dataBase!.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(name, date, time , status) VALUES("$name", "$date", "$time","new")')
          .then((value){
        changeIconAndStateBottom(icon: Icons.edit,isBottomShown: false);
            emit(InsertDataBaseState());
        print('$value is inserted' );
        getDateFormDateBase(dataBase);
      }).catchError((error){
        print('error on row insert ${error.toString()}');
      });
    });
  }

    getDateFormDateBase(dataBase){
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    emit(LoadingGetDataBaseState());
         dataBase!.rawQuery('SELECT * FROM tasks').then((value) {
           value.forEach((element) {
             if (element['status'].toString().contains('new')) {
               newTasks.add(element);
             } else if (element['status'].toString().contains('done')) {
               doneTasks.add(element);
             } else {
               archiveTasks.add(element);
             }
           });
           emit(GetDataBaseState());
         } );}
   upDateFormDateBase({
    required int id,
    required String status,
})async{
    return await dataBase!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [' $status', '$id', ]).then((value)
    {
           getDateFormDateBase(dataBase);
           emit(UpdateDataBaseState());

    });
  }

  void deleteFormDateBase({
  required int id,
})async {
    await dataBase!.rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']).then((value){
      getDateFormDateBase(dataBase);
      emit(DeleteDateBaseState());
    });
  }

}