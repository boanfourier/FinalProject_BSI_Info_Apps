import 'package:bsi_info_apps/data/repository/user_repository.dart';
import 'package:bsi_info_apps/domain/entities/tasks.dart';
import 'package:bsi_info_apps/domain/entities/user.dart';

class GetAllTasksInfo{
  var repository = UserRepository();

  Future<List<TasksEntity>> execute(User user){
    return repository.getTasklist(user);
  }
}