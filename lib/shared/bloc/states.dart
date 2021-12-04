import 'package:todo/shared/bloc/cubit.dart';

abstract class AppStates{}
class InitialAppState extends AppStates{}

class ChangeNavBar extends AppStates{}

class ChangeIconFloAndBottom extends AppStates{}

class CreateDataBaseState extends AppStates{}

class InsertDataBaseState extends AppStates{}

class GetDataBaseState extends AppStates{}

class LoadingGetDataBaseState extends AppStates{}

class UpdateDataBaseState extends AppStates{}

class DeleteDateBaseState extends AppStates{}