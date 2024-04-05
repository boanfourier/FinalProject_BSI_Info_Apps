import 'package:bsi_info_apps/data/repository/user_repository.dart';
import 'package:bsi_info_apps/domain/entities/profile.dart';
import 'package:bsi_info_apps/domain/entities/user.dart';


class GetAllProfileInfo{
  var repository = UserRepository();

  Future<ProfileEntitiy> execute(User user){
    return repository.getProfile(user.username.toString().trim());
  }
}