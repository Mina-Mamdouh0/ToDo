
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/bloc/cubit.dart';
import 'package:todo/shared/bloc/states.dart';
import 'package:todo/shared/component.dart';


class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCubit.get(context).newTasks.isEmpty?Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:const [
           Icon(Icons.menu,size: 70,),
          Text('Empty Task',style: TextStyle(
            fontSize: 30
          ),),
        ],
      ),
    ):BlocConsumer<AppCubit,AppStates>(
      listener:(context,state) {},
      builder: (context,state){
        AppCubit cubit=AppCubit.get(context);
        return ListView.separated(
            itemBuilder: (context,index){
              return taskItem(cubit.newTasks[index],context);
            },
            separatorBuilder: (context,index){
              return Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.black,
              );
            },
            itemCount: cubit.newTasks.length);
      },
    );
  }
}
