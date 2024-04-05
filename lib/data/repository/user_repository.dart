import 'dart:convert';
import 'package:bsi_info_apps/domain/entities/events.dart';
import 'package:bsi_info_apps/domain/entities/profile.dart';
import 'package:bsi_info_apps/domain/entities/tasks.dart';
import '../../domain/entities/user.dart';
import 'package:get_it/get_it.dart';
import '../datasource/source.dart';

final getIt = GetIt.instance;
class UserRepository {
  Future<User> login(User user) async {
    final source = getIt<Source>();
    var json = jsonDecode(await source.login(user.toJson()));
    return User.fromJson(json);
  }

  //Events List
  Future<List<EventsEntity>> getEventslist(User user) async {
    final source = await getIt<Source>();
    var jsonArray = jsonDecode(await source.getEventslist(user.toJson())) as List<dynamic>;
    print(jsonArray.toString());

    List<EventsEntity> listEvents = (jsonArray)
        .map((event) => EventsEntity.fromJson(event as Map<String, dynamic>))
        .toList();
    return listEvents;
  }
  //Profile List
  Future<ProfileEntitiy> getProfile(String username) async {
    final source = getIt<Source>();
    var json = jsonDecode(await source.getProfile(username));
    print(json.toString());
    return ProfileEntitiy.fromJson(json);
  }

  //Tasks List
  Future<List<TasksEntity>> getTasklist(User user) async {
    final source = await getIt<Source>();
    var jsonArray = jsonDecode(await source.getTasklist(user.toJson())) as List<dynamic>;
    print(jsonArray.toString());

    List<TasksEntity> listTasks = (jsonArray)
        .map((tasks) => TasksEntity.fromJson(tasks as Map<String, dynamic>))
        .toList();
    return listTasks;
  }

}
