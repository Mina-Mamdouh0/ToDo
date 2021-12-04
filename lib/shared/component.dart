import 'package:flutter/material.dart';
import 'package:todo/shared/bloc/cubit.dart';

Widget taskItem(Map model,BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction){
        AppCubit.get(context).deleteFormDateBase(id: model['id']);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:  [
           CircleAvatar(
            radius: 40.0,
            child: Text(model['time']),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,

              children:  [
                Text(model['name'],style:const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),),
                Text(model['date'],style:const TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                ),)
              ],
            ),
          ),
          IconButton(onPressed: (){
            AppCubit.get(context).upDateFormDateBase(id: model['id'], status: 'done');
          }, icon: const Icon(Icons.check_box, color: Colors.green,)),

          IconButton(onPressed: (){
            AppCubit.get(context).upDateFormDateBase(id: model['id'], status: 'archive');
          }, icon: const Icon(Icons.archive, color: Colors.red,))

        ],
      ),
    ),
  );
}

Widget defaultTextFiled({
  required BuildContext ctx,
  required String label,
  required String hintText,
  required TextEditingController controller,
  required IconData sufIcon,
  required FormFieldValidator validator,
  GestureTapCallback? onTap,
  ValueChanged<String>? onSubmit,

}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        prefixIcon:  Icon(sufIcon),
        labelText: label,
      ),
      onTap: onTap,
      validator: validator,
      onFieldSubmitted: onSubmit,

    ),
  );
}
