import 'package:bsi_info_apps/data/repository/user_repository.dart';
import 'package:bsi_info_apps/domain/entities/events.dart';
import 'package:bsi_info_apps/domain/entities/user.dart';

class GetAllEventsInfo{
  var repository = UserRepository();

  Future<List<EventsEntity>> execute(User user){
    return repository.getEventslist(user);
  }
}