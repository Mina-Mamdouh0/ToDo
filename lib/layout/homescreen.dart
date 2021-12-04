

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/bloc/cubit.dart';
import 'package:todo/shared/bloc/states.dart';
import 'package:todo/shared/component.dart';

class HomeScreen extends StatelessWidget {

   var titleController=TextEditingController();
   var timeController=TextEditingController();
   var dateController=TextEditingController();
   var scaffoldKey=GlobalKey<ScaffoldState>();
   var formKey=GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is InsertDataBaseState){
            Navigator.of(context).pop();
          }
        },
        builder: (context,state){
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(title: Text(cubit.title[cubit.currentIndex]) ,) ,
            body: state is LoadingGetDataBaseState?const Center(child: CircularProgressIndicator(),):cubit.screen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (val){
                cubit.changeIndex(val);
              },
              items: const [
                BottomNavigationBarItem( icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archived'),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                if(cubit.isBottomSheetShown){
                  if(formKey.currentState!.validate()){
                    cubit.insertToDatabase(
                        name: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                  }
                }
                else{
                  scaffoldKey.currentState!.showBottomSheet((context){
                    return Form(
                      key: formKey,
                      child: Container(
                        color: Colors.grey[300],
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 7,
                            ),
                            defaultTextFiled(
                                ctx: context,
                                hintText: 'Enter The Title',
                                controller: titleController,
                                label: 'Title',
                                sufIcon: Icons.title,
                                validator: (value){
                                  if(value.toString().isEmpty){
                                    return 'Please Enter The Title';
                                  }
                                },
                                onSubmit: (value){
                                  titleController.text=value.toString();
                                  //print(titleController.text);
                                }
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFiled(
                                ctx: context,
                                hintText: 'Enter The Time',
                                controller: timeController,
                                label: 'Time',
                                sufIcon: Icons.access_time_outlined,
                                validator: (value){
                                  if(value.toString().isEmpty){
                                    return 'Please Enter The Time';
                                  }
                                },
                                onTap: (){
                                  showTimePicker(context: context,
                                    initialTime:  TimeOfDay.now(),).then((value) {
                                    timeController.text=value!.format(context).toString();
                                    //  print(timeController.text);
                                  });

                                }
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFiled(
                                ctx: context,
                                hintText: 'Enter The Date',
                                controller: dateController,
                                label: 'Date',
                                sufIcon: Icons.date_range,
                                validator: (value){
                                  if(value.toString().isEmpty){
                                    return 'Please Enter The Date';
                                  }
                                },
                                onTap: (){
                                  showDatePicker(context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(3030)).then((value) {
                                    dateController.text=DateFormat.yMMMd().format(value!).toString() ;
                                    //  print(dateController.text);
                                  });
                                }
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).closed.then((value){
                    cubit.changeIconAndStateBottom(icon: Icons.edit,isBottomShown: false);
                  });
                  cubit.changeIconAndStateBottom(icon: Icons.add,isBottomShown: true);
                }

              },
              child:  Icon(cubit.floShow),
            ),

          );
        },
      )
    );
  }













        }









//create database
//create table
//open database
//insert database
//delete database
//get database

