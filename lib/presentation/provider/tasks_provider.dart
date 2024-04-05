import 'package:bsi_info_apps/domain/entities/tasks.dart';
import 'package:bsi_info_apps/domain/entities/user.dart';
import 'package:bsi_info_apps/domain/use_case/get_all_tasks_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksProvider extends ChangeNotifier{
  var listTasks = <TasksEntity>[];
  SharedPreferences? prefs = null;

  void getTasks() async{
    prefs = await SharedPreferences.getInstance();
    var username = await prefs?.getString('username') ?? '';
    var token = await prefs?.getString('token') ?? '';
    listTasks = await GetAllTasksInfo().execute(User(username: username, token: token));
    notifyListeners();
  }
}